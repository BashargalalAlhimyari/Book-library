import 'package:clean_architecture/core/network/dio_error_handler.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/features/auth/data/data_sourse/auth_remote_data_source.dart';
import 'package:clean_architecture/features/auth/domain/entity/auth_entity.dart';
import 'package:clean_architecture/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepoImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> login({required String email, required String password}) async {
    try {
      final result = await authRemoteDataSource.login(email: email, password: password);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        return left(DioErrorHandler.handle(e));
      }
      return left(ServerFailure( e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({required String username, required String email, required String password}) async {
    try {
      final result = await authRemoteDataSource.register(username: username, email: email, password: password);
      return Right(result);
    } catch (e) {
      if (e is DioException) {
        return left(DioErrorHandler.handle(e));
      }
      return left(ServerFailure( e.toString()));
    }
  }
}
