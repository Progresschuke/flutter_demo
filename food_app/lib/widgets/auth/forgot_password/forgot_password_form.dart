import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:food_app/constant/form_constants.dart';
import 'package:food_app/screens/auth/sign_in.dart';

import 'package:food_app/widgets/auth/form_error.dart';

final firebase = FirebaseAuth.instance;

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String? _enteredEmail = '';
  final List<String?> errors = [];
  bool _isAuthenticating = false;

//To display errors on UI
  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

//To remove errors on UI
  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  // to sign users up
  void _passwordReset() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    try {
      setState(() {
        _isAuthenticating = true;
      });

      await firebase.sendPasswordResetEmail(email: _enteredEmail!);
      setState(() {
        _isAuthenticating = false;
      });
      _showDialog('Tap on the link sent to your email to reset your password.');
    } on FirebaseAuthException catch (error) {
      setState(() {
        _isAuthenticating = false;
      });

      _showDialog(error.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailForm(),
          SizedBox(height: 2 * size.height / 100),
          FormError(errors: errors),
          SizedBox(height: 2 * size.height / 100),
          if (_isAuthenticating) const CircularProgressIndicator(),
          if (!_isAuthenticating)
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                    Size.fromWidth(70 * size.width / 100)),
              ),
              onPressed: _passwordReset,
              child: const Text('Reset Password'),
            ),
          SizedBox(height: 2 * size.height / 100),
          TextButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                  Size.fromWidth(70 * size.width / 100)),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const SignInScreen(),
                ),
              );
            },
            child: const Text('Return to sign in'),
          ),
        ],
      ),
    );
  }

  //Dialog to show error message based on authentication state
  Future _showDialog(String message) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text(message),
          );
        });
  }

//Email TextFormField
  TextFormField buildEmailForm() {
    return TextFormField(
      style: const TextStyle(fontSize: 18),
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Email',
        hintText: 'Enter your email',
        suffixIcon: Icon(Icons.mail_outline),
      ),
      onSaved: (newValue) {
        _enteredEmail = newValue!;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (value.contains('@')) {
          removeError(error: kInvalidEmailError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!value.contains('@')) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
    );
  }
}
