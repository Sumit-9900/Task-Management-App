import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management_app/core/const/const.dart';
import 'package:task_management_app/core/utils/show_snackbar.dart';
import 'package:task_management_app/core/widgets/loader.dart';
import 'package:task_management_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:task_management_app/features/auth/presentation/pages/signin_page.dart';
import 'package:task_management_app/features/auth/presentation/widgets/action_button.dart';
import 'package:task_management_app/features/auth/presentation/widgets/input_field.dart';
import 'package:task_management_app/features/auth/presentation/widgets/two_text.dart';
import 'package:task_management_app/features/task/presentation/pages/task_screen.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(Const.todoImage, fit: BoxFit.cover),
                  const SizedBox(height: 10),
                  Text(
                    'Let\'s get started!',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('EMAIL ADDRESS'),
                      const SizedBox(height: 5.0),
                      InputField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter Email address';
                          } else if (!RegExp(
                            Const.emailRegex,
                          ).hasMatch(value.trim())) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      Text('PASSWORD'),
                      const SizedBox(height: 5.0),
                      InputField(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter Password';
                          } else if (value.trim().length < 6) {
                            return 'Password should be 6 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      Text('CONFIRM PASSWORD'),
                      const SizedBox(height: 5.0),
                      InputField(
                        controller: confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter Password';
                          } else if (value.trim() !=
                              passwordController.text.trim()) {
                            return 'Please enter correct Password';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthFailure) {
                        showSnackBar(context, state.error);
                      } else if (state is AuthSuccess) {
                        if (state.user != null) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => TaskScreen(),
                            ),
                          );
                          showSnackBar(
                            context,
                            'User created successfully!',
                            Colors.green,
                          );
                        } else {
                          showSnackBar(context, 'User creation failed!');
                        }
                      }
                    },
                    builder: (context, state) {
                      final isLoading = (state is AuthLoading);
                      
                      return ActionButton(
                        onPressed:
                            isLoading
                                ? null
                                : () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                      AuthSignUp(
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                      ),
                                    );
                                  }
                                },
                        widget:
                            isLoading
                                ? SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Loader(),
                                )
                                : Text('Sign up'),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  TwoText(
                    text1: 'Already have an account? ',
                    text2: 'Log in',
                    screen: SigninPage(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
