import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class RegisterService {

  final client = http.Client();
  final storage = const FlutterSecureStorage();

  // RegisterService(this.client);

  Future<void> registerUser({
    required String first_name,
    required String last_name,
    required String middle_name,
    required String email,
    required String phone,
    required String password,
    required String password_confirm,
  }) async {
    const url = 'https://go-auth.srv/api/auth/register';

    final Map<String, dynamic> body = {
      "first_name": first_name,
      "last_name": last_name,
      "middle_name": last_name,
      "email": email,
      "phone": phone,
      "password": password,
      "password_confirm": password_confirm,
    };

    print(body);

    final response =
        await client.post(Uri.parse(url), headers: {'X-API-KEY': 'init_d0bb7a213977b8ee3a6096e0f1e5f8a1', 'Content-Type': 'application/json'}, body: jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      final access_token = data['access_token'];
      final refresh_token = data['refresh_token'];

      print('Data registerUser(): $data');

      await storage.deleteAll();
      await storage.write(key: 'accessToken', value: access_token);
      await storage.write(key: 'refreshToken', value: refresh_token);

      String? accessToken = await storage.read(key: 'accessToken');
      String? refreshToken = await storage.read(key: 'refreshToken');

      print('accessToken $accessToken');
      print('refreshToken $refreshToken');
    } else {
      print(response.body);
      throw Exception('registerUser() ${response.statusCode}');
    }
  }
}
