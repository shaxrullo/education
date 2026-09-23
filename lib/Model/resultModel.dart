class QuizSubmitModel {
  // Submit uchun (yuborish)
  final List<AnswerRequest>? answers;

  // Natija uchun (response)
  final int? score;
  final int? totalQuestions;
  final double? percentage;
  final bool? passed;
  final int? correctAnswers;
  final int? wrongAnswers;
  final int? passingScore;

  QuizSubmitModel({
    this.answers,
    this.score,
    this.totalQuestions,
    this.percentage,
    this.passed,
    this.correctAnswers,
    this.wrongAnswers,
    this.passingScore,
  });

  // Yuborish uchun → toJson
  Map<String, dynamic> toJson() => {
    'answers': answers?.map((a) => a.toJson()).toList(),
  };

  // Natija kelganda → fromJson
  factory QuizSubmitModel.fromJson(Map<String, dynamic> json) {
    return QuizSubmitModel(
      score:          json['score'],
      totalQuestions: json['total_questions'],
      percentage:     (json['percentage'] as num).toDouble(),
      passed:         json['passed'],
      correctAnswers: json['correct_answers'],
      wrongAnswers:   json['wrong_answers'],
      passingScore:   json['passing_score'],
    );
  }
}

class AnswerRequest {
  final int questionId;
  final int optionId;

  AnswerRequest({required this.questionId, required this.optionId});

  Map<String, dynamic> toJson() => {
    'question_id': questionId,
    'option_id': optionId,
  };
}
