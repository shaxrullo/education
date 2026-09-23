class OptionModel {
  final int id;
  final String text;

  OptionModel({
    required this.id,
    required this.text,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id:   json['id'],
      text: json['text'] ?? '',
    );
  }
}

// question_model.dart
class QuestionModel {
  final int id;
  final String question;
  final int order;
  final List<OptionModel> options;

  QuestionModel({
    required this.id,
    required this.question,
    required this.order,
    required this.options,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id:       json['id'],
      question: json['question'] ?? '',
      order:    json['order'] ?? 0,
      options:  (json['options'] as List)
                  .map((e) => OptionModel.fromJson(e))
                  .toList(),
    );
  }
}

// quiz_model.dart
class QuizModel {
  final int id;
  final int course;
  final int? lesson;           // ← NULL bo'lishi mumkin
  final String title;
  final String description;
  final int passingScore;
  final bool allowRetakes;
  final int maxAttempts;
  final int questionCount;
  final List<QuestionModel> questions;
  final String createdAt;

  QuizModel({
    required this.id,
    required this.course,
    this.lesson,
    required this.title,
    required this.description,
    required this.passingScore,
    required this.allowRetakes,
    required this.maxAttempts,
    required this.questionCount,
    required this.questions,
    required this.createdAt,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id:            json['id'],
      course:        json['course'],
      lesson:        json['lesson'],               // ← null keladi
      title:         json['title'] ?? '',
      description:   json['description'] ?? '',
      passingScore:  json['passing_score'] ?? 60,  // ← passing_score
      allowRetakes:  json['allow_retakes'] ?? true, // ← allow_retakes
      maxAttempts:   json['max_attempts'] ?? 0,    // ← max_attempts
      questionCount: json['question_count'] ?? 0,  // ← question_count
      questions:     (json['questions'] as List)
                       .map((e) => QuestionModel.fromJson(e))
                       .toList(),
      createdAt:     json['created_at'] ?? '',     // ← created_at
    );
  }
}
