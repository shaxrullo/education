class Teachermodel {
  String name;
  String lastName;
  Teachermodel({required this.lastName, required this.name});
  factory Teachermodel.fromJson(Map<String, dynamic> json) {
    return Teachermodel(
      name: json["name"],
      lastName: json["lastName"]?? "",
    );
  }
}
