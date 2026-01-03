import 'package:dartz/dartz.dart';
import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/features/auth/domain/entity/auth_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> login({required String email, required String password});
  Future<Either<Failure, UserEntity>> register({required String username, required String email, required String password});
}