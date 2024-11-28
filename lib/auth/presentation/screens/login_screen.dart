import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:messenger/features/auth/data/data_sources/login_service.dart';
import 'package:messenger/features/auth/data/repositories_impl/login_repo_impl.dart';
import 'package:messenger/features/auth/domain/use_cases/login_uc.dart';
import 'package:messenger/features/auth/presentation/widgets/login/login_google_button_widget.dart';
import 'package:messenger/features/auth/presentation/widgets/login/login_input_field_widget.dart';
import 'package:messenger/features/auth/presentation/widgets/login/login_main_button_widget.dart';
import 'package:messenger/features/auth/presentation/widgets/login/login_or_register_widget.dart';
import 'package:messenger/features/auth/presentation/widgets/login/login_subtitle_widget.dart';
import 'package:messenger/features/auth/presentation/widgets/login/login_pass_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late http.Client client;
  late bool isLoading;

  Future<void> login() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    print('Форма валидна: $isValid');
    if (!isValid) {
      print('Запрос не отправляется, так как форма невалидна.');
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      await LoginUseCase(LoginRepoImpl(LoginService())).call(
        email: emailController.text,
        password: passwordController.text,
      );
      print('login() try');
    } catch (e) {
      throw Exception('login() catch: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    isLoading = false;
    client = http.Client();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Авторизация',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const LoginSubtitleWidget(),
                  const SizedBox(height: 26),
                  LoginInputFieldWidget(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    label: 'Email',
                    title: 'Email:',
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Бро здесь не должно быть пустым';
                      } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value!)) {
                        return 'Неверный формат email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  LoginInputFieldWidget(
                    controller: passwordController,
                    label: 'Пароль',
                    title: 'Пароль:',
                    obscure: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'пусто';
                      } else if (value!.length < 6) {
                        return 'слишком короткое';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // const LoginPassWidget(),
                  const SizedBox(height: 20),
                  LoginMainButtonWidget(onAsyncAction: login, isLoading: isLoading),
                  const SizedBox(height: 20),
                  const LoginOrRegisterWidget(),
                  const SizedBox(height: 20),
                  const LoginGoogleButtonWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
