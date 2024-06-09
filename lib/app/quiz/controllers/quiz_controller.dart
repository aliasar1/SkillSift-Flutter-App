// ignore_for_file: avoid_print

import 'dart:async';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/helpers/quiz_summary_generator.dart';
import 'package:skillsift_flutter_app/core/local/cache_manager.dart';
import 'package:skillsift_flutter_app/core/models/job_model.dart';
import 'package:skillsift_flutter_app/core/services/job_api.dart';
import '../../../core/models/jobseeker_model.dart';
import '../../../core/models/questions_dataset_model.dart';
import '../../../core/models/quiz_summary_model.dart';
import '../../../core/models/recruiter_model.dart';
import '../../../core/services/auth_api.dart';
import '../../../core/services/fcm_api.dart';
import '../../../core/services/level2_api.dart';
import '../../../core/services/quiz_summary_api.dart';
import '../components/summary_view.dart';

class QuizController extends GetxController with CacheManager {
  RxInt index = 0.obs;
  RxInt correctAns = 0.obs;
  RxInt selectedAnswerIndex = RxInt(-1);
  List<Question> questionsData = [];
  List<QuizSummary> quizSummaries = [];
  Timer? _timer;

  RxDouble secondsRemaining = 10.0.obs;
  RxBool isLoading = false.obs;

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  void clearFields() {
    index.value = 0;
    selectedAnswerIndex.value = -1;
    secondsRemaining.value = 10;
    questionsData = [];
  }

  void clearAllFields() {
    index.value = 0;
    correctAns.value = 0;
    selectedAnswerIndex.value = -1;
    secondsRemaining.value = 10;
    questionsData = [];
    quizSummaries = [];
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value <= 0) {
        timer.cancel();
        if (selectedAnswerIndex.value == -1) {
          quizSummaries.add(QuizSummary(
            question: questionsData[index.value].question,
            choices: questionsData[index.value].choices,
            correctAns: questionsData[index.value]
                .choices[questionsData[index.value].answer],
            userAnswer: "Not answered",
            status: "Missed",
          ));
        } else {
          checkAnswer(
            index.value,
            questionsData[index.value].answer,
          );
        }
        updateIndex();
      } else {
        secondsRemaining.value--;
      }
    });
  }

  void resetTimer() {
    secondsRemaining.value = 10;
    _timer?.cancel();
  }

  void updateIndex() {
    index.value++;
    selectedAnswerIndex.value = -1;
    resetTimer();
    if (index.value < questionsData.length) {
      startTimer();
    } else {
      // End of the quiz, handle accordingly
      _timer?.cancel();
      print("Quiz completed");
    }
  }

  void getListOfRandomQuestions(int length, String type) {
    questionsData.clear();

    if (questions.containsKey(type)) {
      List<Map<String, dynamic>> questionList =
          questions[type] as List<Map<String, dynamic>>;

      questionList.shuffle();

      Set<int> usedIndices = {};

      int addedQuestions = 0;
      while (
          addedQuestions < length && usedIndices.length < questionList.length) {
        int randomIndex = _getRandomIndex(questionList.length);
        if (!usedIndices.contains(randomIndex)) {
          Map<String, dynamic> data = questionList[randomIndex];
          Question question = Question(
            question: data["question"],
            choices: List<String>.from(data["choices"] as List<dynamic>),
            answer: data["answer"] as int,
            difficultyLevel: data["difficulty_level"] as String,
          );
          if (!_questionExists(question)) {
            questionsData.add(question);
            usedIndices.add(randomIndex);
            addedQuestions++;
          }
        }
      }
    }
  }

  int _getRandomIndex(int length) {
    return DateTime.now().millisecondsSinceEpoch % length;
  }

  bool _questionExists(Question newQuestion) {
    return questionsData
        .any((question) => question.question == newQuestion.question);
  }

  void setSelectedAnswerIndex(int index) {
    selectedAnswerIndex.value = index;
  }

  void checkAnswer(int questionIndex, int correctAnswerIndex) {
    print(questionIndex);
    print(correctAnswerIndex);
    print(selectedAnswerIndex.value);
    if (selectedAnswerIndex.value == correctAnswerIndex) {
      correctAns.value++;
      quizSummaries.add(QuizSummary(
        question: questionsData[questionIndex].question,
        choices: questionsData[questionIndex].choices,
        correctAns: questionsData[questionIndex].choices[correctAnswerIndex],
        userAnswer:
            questionsData[questionIndex].choices[selectedAnswerIndex.value],
        status: "Correct",
      ));
    } else {
      quizSummaries.add(QuizSummary(
        question: questionsData[questionIndex].question,
        choices: questionsData[questionIndex].choices,
        correctAns: questionsData[questionIndex].choices[correctAnswerIndex],
        userAnswer:
            questionsData[questionIndex].choices[selectedAnswerIndex.value],
        status: "Incorrect",
      ));
    }
  }

  Future<void> generateQuizSummaryPdf() async {
    final file = await PdfGenerator.generateQuizSummaryPdf(quizSummaries);
    Get.to(QuizSummaryView(
      file: file,
    ));
  }

  Future<bool> checkIfApplicationExists(String applicationId) async {
    try {
      bool resp = await Level2Api.checkIfApplicationIdExists(applicationId);
      return resp;
    } catch (e) {
      print('Error adding score: $e');
      return false;
    }
  }

  Future<void> addQuizAttempt(String applicationId) async {
    try {
      await QuizSummaryApi.addQuizSummary(applicationId, quizSummaries);
    } catch (e) {
      print('Error adding score: $e');
    }
  }

  Future<void> addScore(String applicationId, int score, String status,
      String qnaId, String jobId) async {
    try {
      await Level2Api.addScore(applicationId, score, status, qnaId);
      final resp = await JobApi.getJobById(jobId);
      Job job = Job.fromJson(resp);
      final response = await AuthApi.getCurrentUser(false, getId()!);
      final jobseeker = JobSeeker.fromJson(response);
      final r = await AuthApi.getCurrentUser(true, job.recruiterId);
      final recruiter = Recruiter.fromJson(r);
      final tokens =
          await FCMNotificationsApi.getAllTokensOfUser(recruiter.userId);
      if (tokens != null) {
        await FCMNotificationsApi.sendNotificationToAllTokens(
          tokens,
          'Quiz submitted for ${job.title}',
          '${jobseeker.fullname} has submitted Quiz for the ${job.title} job.',
        );
      }
    } catch (e) {
      print('Error adding score: $e');
    }
  }

  Future<int> getScoreByApplicationId(String applicationId) async {
    try {
      final level2 = await Level2Api.getScoreByApplicationId(applicationId);
      return level2.score;
    } catch (e) {
      print('Error getting score: $e');
      return -1;
    }
  }

  Future<void> updateStatusByApplicationId(
      String applicationId, String status) async {
    try {
      await Level2Api.updateStatusByApplicationId(applicationId, status);
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  Future<void> loadQuizSummary(String applicationId) async {
    try {
      quizSummaries =
          await QuizSummaryApi.getQuizSummariesByApplicationId(applicationId);
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
