import 'package:messenger/features/auth/data/data_sources/login_service.dart';
import 'package:messenger/features/auth/domain/repositories/login_repo.dart';

class LoginRepoImpl implements LoginRepo {
  final LoginService loginService;

  LoginRepoImpl(this.loginService);

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    return await loginService.loginUser(
      email: email,
      password: password,
    );
  }
}
