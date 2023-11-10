import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:food_app/constant/form_constants.dart';
import 'package:food_app/screens/auth/complete_profile.dart';

import 'package:food_app/widgets/auth/form_error.dart';

final firebase = FirebaseAuth.instance;

class EmailSignUpForm extends StatefulWidget {
  const EmailSignUpForm({super.key});

  @override
  State<EmailSignUpForm> createState() => _EmailSignUpFormState();
}

class _EmailSignUpFormState extends State<EmailSignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? _enteredEmail = '';
  String? _enteredPassword = '';
  String? _confirmPassword = '';
  final List<String?> errors = [];
  bool _isHidden = true;
  bool _isConfirmHidden = true;
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

  //To encrypt or decrypt passwords
  void _hidePassword() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  //To encrypt or decrypt passwords
  void _hideConfirmPassword() {
    setState(() {
      _isConfirmHidden = !_isConfirmHidden;
    });
  }

  // to sign users up
  void _signUp() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    try {
      setState(() {
        _isAuthenticating = true;
      });

      final userCredential = await firebase.createUserWithEmailAndPassword(
          email: _enteredEmail!, password: _enteredPassword!);

      if (mounted) {}
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const CompleProfile()),
      );
    } on FirebaseAuthException catch (error) {
      setState(() {
        _isAuthenticating = false;
      });
      if (error.code == 'email-already-in-use') {
        _showSnackBar(error.message);
      } else if (error.code == 'weak-password') {
        _showSnackBar(error.message);
      } else {
        _showSnackBar(error.code);
      }
    }
  }

//Snackbar to show error message based on authentication state
  void _showSnackBar(String? message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message!)));
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
          buildPasswordForm(),
          SizedBox(height: 2 * size.height / 100),
          buildConfirmPasswordForm(),
          SizedBox(height: 3 * size.height / 100),
          FormError(errors: errors),
          SizedBox(height: 2 * size.height / 100),
          if (_isAuthenticating) const CircularProgressIndicator(),
          if (!_isAuthenticating)
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                    Size.fromWidth(70 * size.width / 100)),
              ),
              onPressed: _signUp,
              child: const Text('Sign Up'),
            ),
        ],
      ),
    );
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

//Password TextFormField
  TextFormField buildPasswordForm() {
    return TextFormField(
      style: const TextStyle(fontSize: 18),
      autocorrect: false,
      obscureText: _isHidden ? true : false,
      textCapitalization: TextCapitalization.none,
      enableSuggestions: false,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        suffixIcon: GestureDetector(
          onTap: _hidePassword,
          child: _isHidden
              ? const Icon(Icons.lock_outline)
              : const Icon(Icons.lock_open),
        ),
      ),
      onSaved: (newValue) {
        _enteredPassword = newValue!;
      },
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPasswordNullError)) {
          removeError(error: kPasswordNullError);
        } else if (value.length > 8) {
          removeError(error: kShortPasswordError);
        } else if (value.length < 8 && value.isNotEmpty) {
          addError(error: kShortPasswordError);
        }
        _enteredPassword = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPasswordNullError);
          return "";
        } else if (value.length <= 8 && value.isNotEmpty) {
          addError(error: kShortPasswordError);
          return "";
        }
        return null;
      },
    );
  }

//Confirm Password TextFormField
  TextFormField buildConfirmPasswordForm() {
    return TextFormField(
      style: const TextStyle(fontSize: 18),
      autocorrect: false,
      obscureText: _isConfirmHidden ? true : false,
      textCapitalization: TextCapitalization.none,
      enableSuggestions: false,
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        hintText: 'Re-Enter your password',
        suffixIcon: GestureDetector(
          onTap: _hideConfirmPassword,
          child: _isConfirmHidden
              ? const Icon(Icons.lock_outline)
              : const Icon(Icons.lock_open),
        ),
      ),
      onSaved: (newValue) {
        _confirmPassword = newValue!;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kConfirmPasswordError);
          removeError(error: kPasswordMatchError);
        } else if (value == _enteredPassword &&
            errors.contains(kConfirmPasswordError)) {
          removeError(error: kPasswordMatchError);
        }
        _confirmPassword = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kConfirmPasswordError);
          return "";
        } else if (value != _enteredPassword) {
          addError(error: kPasswordMatchError);
          return "";
        }
        return null;
      },
    );
  }
}
