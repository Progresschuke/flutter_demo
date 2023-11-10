import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:food_app/constant/form_constants.dart';
import 'package:food_app/screens/auth/forgot_password.dart';
import 'package:food_app/screens/tab.dart';
import 'package:food_app/widgets/auth/form_error.dart';

final _firebase = FirebaseAuth.instance;

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _isLogin = true;
  final List<String?> errors = [];
  bool _isHidden = true;
  bool? _rememberMe = false;
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
  void hidePassword() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

// To reset password
  void _forgotPassword() {
    _showDialog('This action will reset your password. \nTap Ok to continue');
  }

// to sign users in
  void _signIn() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    try {
      setState(() {
        _isAuthenticating = true;
      });

      if (_isLogin) {
        final userCredential = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        if (!context.mounted) {
          return;
        }
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => const TabScreen()));
      }
    } on FirebaseAuthException catch (error) {
      setState(() {
        _isAuthenticating = false;
      });
      if (error.code == 'user-not-found') {
        _showSnackBar(error.message!);
      } else if (error.code == 'wrong-password') {
        _showSnackBar(error.message!);
      }
    }
  }

// to show snackbar message based on the state of authentication
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  //Dialog to show error message based on authentication state
  Future _showDialog(String message) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceBetween,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Action Required'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(_);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const ForgotPassword()));
                },
                child: const Text('Ok'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailForm(),
          SizedBox(height: 3 * size.height / 100),
          buildPasswordForm(),
          SizedBox(height: 5 * size.height / 100),
          Row(
            children: [
              Checkbox(
                value: _rememberMe,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value;
                  });
                },
              ),
              SizedBox(height: 3 * size.height / 100),
              const Text('Remember me'),
              const Spacer(),
              GestureDetector(
                  onTap: _forgotPassword,
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ))
            ],
          ),
          SizedBox(height: 5 * size.height / 100),
          FormError(errors: errors),
          if (_isAuthenticating) const CircularProgressIndicator(),
          if (!_isAuthenticating)
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                    Size.fromWidth(70 * size.width / 100)),
              ),
              onPressed: _signIn,
              child: const Text('Sign In'),
            ),
        ],
      ),
    );
  }

//Email Textformfield
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
        return;
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

//Password Textformfield
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
          onTap: hidePassword,
          child: _isHidden
              ? const Icon(Icons.lock_outline)
              : const Icon(Icons.lock_open),
        ),
      ),
      onSaved: (newValue) {
        _enteredPassword = newValue!;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPasswordNullError);
        } else if (value.length > 8) {
          removeError(error: kShortPasswordError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPasswordNullError);
          return "";
        } else if (value.trim().length <= 8) {
          addError(error: kShortPasswordError);
          return "";
        }
        return null;
      },
    );
  }
}
