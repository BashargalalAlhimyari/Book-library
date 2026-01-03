import 'package:dartz/dartz.dart';
import 'package:clean_architecture/core/errors/failure.dart';
import 'package:clean_architecture/core/userCases/usecase.dart';
import 'package:clean_architecture/features/auth/domain/entity/auth_entity.dart';
import 'package:clean_architecture/features/auth/domain/repo/auth_repo.dart';

class RegisterUseCase extends UseCase<UserEntity, RegisterParams> {
  final AuthRepo authRepo;

  RegisterUseCase(this.authRepo);

  @override
  Future<Either<Failure, UserEntity>> call(RegisterParams param) async {
    return await authRepo.register(
      username: param.username,
      email: param.email,
      password: param.password,
    );
  }
}

class RegisterParams {
  final String username;
  final String email;
  final String password;

  RegisterParams({
    required this.username,
    required this.email,
    required this.password,
  });
}
