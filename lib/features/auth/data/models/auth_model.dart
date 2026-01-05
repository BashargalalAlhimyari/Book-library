import 'package:clean_architecture/features/auth/domain/entity/auth_entity.dart';

class AuthModel extends UserEntity {
  AuthModel({
    required super.email,
    required super.username,
    required super.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
    };
  }
}
