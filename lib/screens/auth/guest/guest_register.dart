import 'package:flutter/material.dart';
import 'package:hotel_management/components/reusable_textformfield.dart';

import 'package:hotel_management/providers/user_provider.dart';
import 'package:hotel_management/utils/common_functions.dart';
import 'package:provider/provider.dart';

class GuestRegister extends StatefulWidget {
  const GuestRegister({super.key});

  @override
  State<GuestRegister> createState() => _GuestRegisterState();
}

class _GuestRegisterState extends State<GuestRegister> {
  bool pressedLogin = false;
  bool isSecure = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  controller: nameController,
                  label: 'name',
                ),
                Commonfunctions.gapMultiplier(),
                ReusableTextFormField(
                  label: 'email',
                  addEmailValidation: true,
                  controller: emailController,
                ),
                Commonfunctions.gapMultiplier(),
                ReusableTextFormField(
                  obscureText: isSecure,
                  label: 'Password',
                  controller: passwordController,
                ),
              ],
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () async {
              await _handleSignup();
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSignup() async {
    setState(() {
      pressedLogin = true;
    });
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<UserProvider>(context, listen: false);

      await authProvider.signupGuest(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
      );
    }
  }
}
