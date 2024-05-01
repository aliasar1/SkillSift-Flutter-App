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

  factory QuizSummary.fromJson(Map<String, dynamic> json) {
    return QuizSummary(
      question: json['question'],
      choices: List<String>.from(json['choices']),
      correctAns: json['correctAns'],
      userAnswer: json['userAnswer'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'choices': choices,
      'correctAns': correctAns,
      'userAnswer': userAnswer,
      'status': status,
    };
  }
}
