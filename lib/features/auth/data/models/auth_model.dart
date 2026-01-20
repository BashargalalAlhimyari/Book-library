import 'package:clean_architecture/core/common/type_def/typesdef.dart';
import 'package:clean_architecture/features/auth/domain/entity/auth_entity.dart';

class AuthModel extends UserEntity {
  AuthModel({
    required super.email,
    required super.username,
    required super.token,
     required super.id,
  });

  factory AuthModel.fromJson(JsonMap json) {
    return AuthModel(
      id: json['user']['id'] ?? '',
      email: json['user']['email'] ?? 'guest@gmail.com',
      username: json['user']['username'] ?? 'Guest',
      token: json['token'] ?? '',
    );
  }

 JsonMap toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
    };
  }
}
