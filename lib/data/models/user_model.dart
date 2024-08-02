class UserModel {

  final String? id;
  final String fullName;
  final int age;
  final String gender;
  final String email;
  final String password;

  //constructor del objeto
  UserModel({
    this.id,
    required this.fullName,
    required this.age,
    required this.gender,
    required this.email,
    required this.password,
  });

  //método para convertir el objeto json a un UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['fullName'],
      age: json['age'],
      gender: json['gender'],
      email: json['email'],
      password: json['password'],
    );
  }

  //método para convertir el objeto a json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'age': age,
      'gender': gender,
      'email': email,
      'password': password,
    };
  }
}