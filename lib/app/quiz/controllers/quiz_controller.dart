import 'dart:async';

import 'package:get/get.dart';
import '../../../core/models/questions_dataset_model.dart';

class QuizController extends GetxController {
  RxInt index = 0.obs;
  RxInt correctAns = 0.obs;
  RxInt selectedAnswerIndex = RxInt(-1);
  List<Question> questionsData = [];
  Timer? _timer;

  RxDouble secondsRemaining = 10.0.obs;
  RxBool isLoading = false.obs;

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  void clearFields() {
    index.value = 0;
    correctAns.value = 0;
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
          checkAnswer(-1, questionsData[index.value].answer);
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
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
