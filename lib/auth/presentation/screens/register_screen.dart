import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:messenger/features/auth/data/data_sources/register_service.dart';
import 'package:messenger/features/auth/data/repositories_impl/register_repo_impl.dart';
import 'package:messenger/features/auth/domain/use_cases/register_uc.dart';
import 'package:messenger/features/auth/presentation/widgets/register/register_google_button_widget.dart';
import 'package:messenger/features/auth/presentation/widgets/register/register_input_field_widget.dart';
import 'package:messenger/features/auth/presentation/widgets/register/register_main_button_widget.dart';
import 'package:messenger/features/auth/presentation/widgets/register/register_or_login_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController firstNameController;
  late TextEditingController middleNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmController;
  late bool isLoading;
  late http.Client client;

  final maskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  Future<void> register() async {
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
      await RegisterUseCase(RegisterRepoImpl(RegisterService())).call(
        first_name: firstNameController.text,
        last_name: lastNameController.text,
        middle_name: middleNameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
        password_confirm: passwordConfirmController.text,
      );
      print('register() try');
    } catch (e) {
      print('register() catch: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isLoading = false;

    _formKey = GlobalKey<FormState>();
    client = http.Client();
    firstNameController = TextEditingController();
    middleNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                    'Регистрация',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  RegisterInputFieldWidget(
                    controller: firstNameController,
                    label: 'first_name',
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
                  RegisterInputFieldWidget(
                    controller: lastNameController,
                    label: 'last_name',
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
                  RegisterInputFieldWidget(
                    controller: middleNameController,
                    label: 'middle_name',
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
                  RegisterInputFieldWidget(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    label: 'email',
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'пусто';
                      } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value!)) {
                        return 'неверный формат email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  RegisterInputFieldWidget(
                    keyboardType: TextInputType.number,
                    controller: phoneController,
                    inputFormatters: [maskFormatter],
                    label: 'phone',
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
                  RegisterInputFieldWidget(
                    controller: passwordController,
                    label: 'password',
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
                  RegisterInputFieldWidget(
                    controller: passwordConfirmController,
                    label: 'password_confirm',
                    obscure: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'пусто';
                      } else if (value != passwordController.text) {
                        return 'не походе на passwordController';
                      }
                      return null;
                    },
                  ),
                  // const RegisterPassWidget(),
                  const SizedBox(height: 20),
                  RegisterMainButtonWidget(
                    onAsyncAction: register,
                    isLoading: isLoading,
                  ),
                  const SizedBox(height: 20),
                  const RegisterOrLoginWidget(),
                  const SizedBox(height: 20),
                  const RegisterGoogleButtonWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
