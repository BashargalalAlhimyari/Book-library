import 'package:clean_architecture/core/common/type_def/typesdef.dart';
import 'package:clean_architecture/core/userCases/usecase.dart';
import 'package:clean_architecture/features/auth/domain/entity/auth_entity.dart';
import 'package:clean_architecture/features/auth/domain/repo/auth_repo.dart';

class LoginUseCase extends UseCase<UserEntity, LoginParams> {
  final AuthRepo authRepo;

  LoginUseCase(this.authRepo);

  @override
 ResultFuture<UserEntity>  call(LoginParams param) async {
    return await authRepo.login(email: param.email, password: param.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
