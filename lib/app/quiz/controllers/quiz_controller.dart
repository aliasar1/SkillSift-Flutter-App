import 'dart:async';
import 'package:get/get.dart';
import 'package:skillsift_flutter_app/core/helpers/quiz_summary_generator.dart';
import '../../../core/models/questions_dataset_model.dart';
import '../../../core/models/quiz_summary_model.dart';
import '../components/summary_view.dart';

class QuizController extends GetxController {
  RxInt index = 0.obs;
  RxInt correctAns = 0.obs;
  RxInt selectedAnswerIndex = RxInt(-1);
  List<Question> questionsData = [];
  List<QuizSummary> quizSummaries = []; // Store quiz summaries
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

  @override
  void onInit() {
    super.onInit();
    getListOfRandomQuestions(10, "information_technology");
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
          checkAnswer(index.value, questionsData[index.value].answer);
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
    startTimer();
  }

  void getListOfRandomQuestions(int length, String type) {
    questionsData.clear();

    if (questions.containsKey(type)) {
      List<Map<String, dynamic>> questionList =
          questions[type] as List<Map<String, dynamic>>;

      questionList.shuffle();

      for (int i = 0; i < length && i < questionList.length; i++) {
        Map<String, dynamic> data = questionList[i];
        questionsData.add(Question(
          question: data["question"],
          choices: List<String>.from(data["choices"] as List<dynamic>),
          answer: data["answer"] as int,
          difficultyLevel: data["difficulty_level"] as String,
        ));
      }
    }
  }

  void setSelectedAnswerIndex(int index) {
    selectedAnswerIndex.value = index;
  }

  void checkAnswer(int index, int ansIndex) {
    if (index == ansIndex) {
      correctAns.value++;
      quizSummaries.add(QuizSummary(
        question: questionsData[index].question,
        choices: questionsData[index].choices,
        correctAns: questionsData[index].choices[ansIndex],
        userAnswer: questionsData[index].choices[selectedAnswerIndex.value],
        status: "Correct",
      ));
    } else {
      quizSummaries.add(QuizSummary(
        question: questionsData[index].question,
        choices: questionsData[index].choices,
        correctAns: questionsData[index].choices[ansIndex],
        userAnswer: questionsData[index].choices[selectedAnswerIndex.value],
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

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
