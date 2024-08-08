// ignore_for_file: file_names

class UserModel {
  final String id;
  final String name;
  final String email;
  // Add other properties as needed

  UserModel({required this.id, required this.name, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['username'],
      email: json['email'],
    );
  }
}
