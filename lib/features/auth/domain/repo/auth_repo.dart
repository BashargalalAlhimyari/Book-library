import 'package:clean_architecture/core/common/type_def/typesdef.dart';
import 'package:clean_architecture/features/auth/domain/entity/auth_entity.dart';

abstract class AuthRepo {
 ResultFuture<UserEntity>  login({required String email, required String password});
  ResultFuture<UserEntity> register({required String username, required String email, required String password});
}