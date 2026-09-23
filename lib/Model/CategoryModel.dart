class CategoryModel {
  final int id;
  final String title;
  final String? description;
  final String? image;
  final String? icon;
  final DateTime createdAt;

  CategoryModel({
    required this.id,
    required this.title,
    this.description,
    this.image,
    required this.createdAt,
    this.icon
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'],
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      icon: json['icon'] ??'',

    );
  }
}