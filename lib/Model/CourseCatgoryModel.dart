class CourseCategoryModel {
  final int id;
  final String title;

  CourseCategoryModel({required this.id, required this.title});

  factory CourseCategoryModel.fromJson(Map<String, dynamic> json) {
    return CourseCategoryModel(
      id: json['id'],
      title: json['title'],
    );
  }
}