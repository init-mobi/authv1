abstract class RegisterRepo {
  Future<void> register({
    required String first_name,
    required String last_name,
    required String middle_name,
    required String email,
    required String phone,
    required String password,
    required String password_confirm,
  });
}
