import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/services/auth/auth_services.dart';
import 'package:personal_expense_tracker/widgets/custom_text_field.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int _currentStep = 0;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final AuthServices authServices = AuthServices();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void signUp() {
    authServices.signUp(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      context: context,
    );
  }

  void signIn() {
    authServices.signIn(
      context: context,
      email: emailController.text,
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Welcome",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Stepper(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          connectorThickness: 2,
          connectorColor: _currentStep == 0
              ? const WidgetStatePropertyAll(Colors.grey)
              : const WidgetStatePropertyAll(Colors.black),
          elevation: 2,
          type: StepperType.horizontal,
          controlsBuilder: (context, details) {
            return const SizedBox();
          },
          currentStep: _currentStep,
          steps: [
            Step(
              isActive: _currentStep == 0,
              title: Text(
                "SingUp",
                style: TextStyle(
                  fontSize: _currentStep == 0 ? 22 : 18,
                  fontWeight:
                      _currentStep == 0 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              content: Column(
                children: [
                  CustomTextField(
                    hinttext: "Name",
                    icon: Icons.text_fields,
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    hinttext: "Email",
                    icon: Icons.mail,
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    isPass: true,
                    hinttext: "Password",
                    icon: Icons.password,
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: signUp,
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Step(
              isActive: _currentStep == 1,
              title: Text(
                "SingIn",
                style: TextStyle(
                  fontSize: _currentStep == 1 ? 22 : 18,
                  fontWeight:
                      _currentStep == 1 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              content: Column(
                children: [
                  CustomTextField(
                    hinttext: "Email",
                    icon: Icons.mail,
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    isPass: true,
                    hinttext: "Password",
                    icon: Icons.password,
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: signIn,
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          onStepTapped: (value) {
            _currentStep = value;
            setState(() {});
          },
        ),
      ),
    );
  }
}
