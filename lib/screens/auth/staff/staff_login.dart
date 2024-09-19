import 'package:flutter/material.dart';
import 'package:hotel_management/components/reusable_textformfield.dart';
import 'package:hotel_management/constant/kenums.dart';
import 'package:hotel_management/providers/user_provider.dart';

import 'package:hotel_management/utils/common_functions.dart';
import 'package:provider/provider.dart';

class StaffLogin extends StatefulWidget {
  const StaffLogin({super.key});

  @override
  State<StaffLogin> createState() => _StaffLoginState();
}

class _StaffLoginState extends State<StaffLogin> {
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
        title: const Text('Staff Login'),
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
      await authProvider.loginGuestStaff(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        role: KEnumUserRole.staff,
      );
    }
  }
}
