import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginService {

  // final client = HttpClientManager.getClient();
  final client = http.Client();
  final storage = const FlutterSecureStorage();

  // final http.Client client;

  // LoginService(this.client);

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    const url = 'https://go-auth.srv/api/auth/login';
    final Map<String, dynamic> body = {
      "email": email,
      "password": password,
    };

    print(body);

    final response =
        await client.post(Uri.parse(url), headers: {'X-API-KEY': 'init_d0bb7a213977b8ee3a6096e0f1e5f8a1', 'Content-Type': 'application/json'}, body: jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      print('Data fetched successfully: $data');

    } else {
      print(response.body);
      throw Exception('LoginService() loginUser() statusCode ${response.statusCode}');
    }
  }
}
