import 'package:clean_architecture/features/auth/domain/entity/auth_entity.dart';

class AuthModel extends UserEntity {
  AuthModel({
    required super.email,
    required super.username,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      email: json['email'] ?? '',
      username: json['username'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
    };
  }
}
