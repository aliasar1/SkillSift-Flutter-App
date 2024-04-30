import 'package:get/get.dart';
import '../../../core/models/questions_dataset_model.dart';

class QuizController extends GetxController {
  RxInt index = 0.obs;
  RxInt selectedAnswerIndex =
      RxInt(-1); // Initialize with -1 to indicate no selection
  List<Question> questionsData = [];

  Rx<bool> isLoading = false.obs;

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  @override
  void onInit() {
    super.onInit();
    // Call the function to get a list of random questions when the controller initializes
    getListOfRandomQuestions(5, "information_technology");
  }

  void updateIndex() {
    index.value++;
    // Reset selected answer index when moving to the next question
    selectedAnswerIndex.value = -1;
  }

  void getListOfRandomQuestions(int length, String type) {
    // Clear the existing list of questions
    questionsData.clear();

    // Check if the specified type exists in the questions JSON
    if (questions.containsKey(type)) {
      List<Map<String, dynamic>> questionList =
          questions[type] as List<Map<String, dynamic>>;

      // Shuffle the question list
      questionList.shuffle();

      // Take a subset of questions based on the specified length
      for (int i = 0; i < length && i < questionList.length; i++) {
        Map<String, dynamic> data = questionList[i];
        questionsData.add(Question(
          question: data["question"],
          choices: List<String>.from(data["choices"] as List<dynamic>),
          answer: data["answer"] as int,
          difficultyLevel: data["difficulty_level"] as String,
        ));
      }
    } else {
      print("Type '$type' not found in questions JSON.");
    }
  }

  void setSelectedAnswerIndex(int index) {
    selectedAnswerIndex.value = index;
  }
}
