import 'package:messenger/features/auth/data/data_sources/register_service.dart';
import 'package:messenger/features/auth/domain/repositories/register_repo.dart';

class RegisterRepoImpl implements RegisterRepo {
  final RegisterService registerService;

  RegisterRepoImpl(this.registerService);

  @override
  Future<void> register({
    required String first_name,
    required String last_name,
    required String middle_name,
    required String email,
    required String phone,
    required String password,
    required String password_confirm,
  }) async {
    return await registerService.registerUser(
      first_name: first_name,
      last_name: last_name,
      middle_name: middle_name,
      email: email,
      phone: phone,
      password: password,
      password_confirm: password_confirm,
    );
  }
}
