class UserModel {
   final String name;
  final String email;
  final String image;

  UserModel({required this.name, required this.email, required this.image});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'image': image,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      image: map['image'] as String,
    );
  }
}
