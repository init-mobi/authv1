import 'package:messenger/features/auth/domain/repositories/login_repo.dart';

class LoginUseCase {
  final LoginRepo repo;

  LoginUseCase(this.repo);

  Future<void> call({
    required String email,
    required String password,
  }) async {
    return await repo.login(
      email: email,
      password: password,
    );
  }
}
