import 'package:flutter/material.dart';
import 'package:hotel_management/components/reusable_textformfield.dart';
import 'package:hotel_management/constant/ktheme.dart';
import 'package:hotel_management/screens/auth/guest/guest_register.dart';
import 'package:hotel_management/screens/auth/staff/staff_login.dart';
import 'package:hotel_management/utils/common_functions.dart';
import 'package:hotel_management/utils/kroute.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool pressedLogin = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              onChanged: () {
                if (pressedLogin) {
                  _formKey.currentState!.validate();
                }
              },
              child: Column(
                children: [
                  ReusableTextFormField(
                    label: 'email',
                    addEmailValidation: true,
                    controller: emailController,
                  ),
                  Commonfunctions.gapMultiplier(),
                  ReusableTextFormField(
                    obscureText: true,
                    label: 'Password',
                    controller: passwordController,
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _handleLogin();
              },
              child: const Text('Login'),
            ),
            Commonfunctions.gapMultiplier(),
            const Spacer(),
            InkWell(
              child: const Text(
                'New User? Signup here',
                style: KTheme.linkTextStyle,
              ),
              onTap: () {
                KRoute.push(context: context, page: const GuestRegister());
              },
            ),
            InkWell(
              child: const Text(
                'Staff? Login here',
                style: KTheme.linkTextStyle,
              ),
              onTap: () {
                KRoute.push(context: context, page: const StaffLogin());
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    setState(() {
      pressedLogin = true;
    });
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<UserProvider>(context, listen: false);
      authProvider.login(
        emailController.text,
        passwordController.text,
      );
    }
  }
}
