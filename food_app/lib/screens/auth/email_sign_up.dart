import 'package:flutter/material.dart';
import 'package:food_app/widgets/auth/email_sign_up/email_sign_up_body.dart';

class EmailSignUpScreen extends StatelessWidget {
  const EmailSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: EmailSignUpBody(),
    );
  }
}
