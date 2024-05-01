class QuizSummary {
  final String question;
  final List<String> choices;
  final String correctAns;
  final String userAnswer;
  final String status;

  QuizSummary({
    required this.question,
    required this.choices,
    required this.correctAns,
    required this.userAnswer,
    required this.status,
  });
}
