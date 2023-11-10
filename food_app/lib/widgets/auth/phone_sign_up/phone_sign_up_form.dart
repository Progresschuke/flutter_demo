import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:get/get.dart';

import 'package:food_app/constant/form_constants.dart';
import 'package:food_app/screens/auth/otp.dart';
import 'package:food_app/widgets/auth/form_error.dart';

final firebase = FirebaseAuth.instance;

class PhoneSignUpForm extends StatefulWidget {
  const PhoneSignUpForm({super.key});

  @override
  State<PhoneSignUpForm> createState() => _PhoneSignUpFormState();
}

class _PhoneSignUpFormState extends State<PhoneSignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? firstName = '';
  String? _lastName = "";
  String? _address = "";
  String? _phoneNumber = '';
  final List<String?> errors = [];

  Country selectedCountry = Country(
    phoneCode: "234",
    countryCode: "NG",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "Nigeria",
    example: "Nigeria",
    displayName: "Nigeria",
    displayNameNoCountryCode: "NG",
    e164Key: "",
  );

//To add errors on UI
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

//To get OTP for verification
  void _getOtp() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }

    signInWithPhoneNumber('+${selectedCountry.phoneCode} $_phoneNumber');
  }

// to store user credentials
  void _storeUserData(User? user) async {
    // final user = firebase.currentUser;
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'firstName': firstName,
      'lastName': _lastName,
      'address': _address,
      'phone': '+${selectedCountry.phoneCode} $_phoneNumber',
    });
  }

  void signInWithPhoneNumber(String enteredNumber) async {
    await firebase.verifyPhoneNumber(
      phoneNumber: enteredNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await firebase.signInWithCredential(credential);

        //Do something to show successful verification
        _showSnackBar('Phone number verified successfully');
      },
      verificationFailed: (FirebaseAuthException error) {
        //Do something to show failed verification
        _showSnackBar(error.code);
      },
      codeSent: (verificationId, forceResendingToken) async {
        String? smsCode = '';
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          smsCode: smsCode,
          verificationId: verificationId,
        );
        Get.to(const OtpScreen(), arguments: [verificationId, firstName]);
        await firebase.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  // to show snackbar message based on the state of authentication
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameForm(),
          SizedBox(height: 2 * size.height / 100),
          buildLastNameForm(),
          SizedBox(height: 2 * size.height / 100),
          buildAddressForm(),
          SizedBox(height: 3 * size.height / 100),
          buildPhoneNumberForm(),
          SizedBox(height: 3 * size.height / 100),
          FormError(errors: errors),
          SizedBox(height: 2 * size.height / 100),
          ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                    Size.fromWidth(70 * size.width / 100)),
              ),
              onPressed: _getOtp,
              child: const Text('Get OTP'))
        ],
      ),
    );
  }

//First name TextFormField
  TextFormField buildFirstNameForm() {
    return TextFormField(
      style: const TextStyle(fontSize: 18),
      autocorrect: false,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        labelText: 'First Name',
        hintText: 'Enter your first name',
        suffixIcon: Icon(Icons.person_2_outlined),
      ),
      onSaved: (newValue) {
        firstName = newValue;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
          removeError(error: kInvalidNameError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        } else if (value.length < 4) {
          addError(error: kInvalidNameError);
          return "";
        }
        return null;
      },
    );
  }

//Last name TextFormField
  TextFormField buildLastNameForm() {
    return TextFormField(
      style: const TextStyle(fontSize: 18),
      autocorrect: false,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        labelText: 'Last Name',
        hintText: 'Enter your last name',
        suffixIcon: Icon(Icons.person_2_outlined),
      ),
      onSaved: (newValue) {
        _lastName = newValue;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
          removeError(error: kInvalidNameError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNameNullError);
          return "";
        } else if (value.length < 4) {
          addError(error: kInvalidNameError);
          return "";
        }
        return null;
      },
    );
  }

//Address TextFormField
  TextFormField buildAddressForm() {
    return TextFormField(
      style: const TextStyle(fontSize: 18),
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.streetAddress,
      decoration: const InputDecoration(
        labelText: 'Address',
        hintText: 'Enter your address',
        suffixIcon: Icon(Icons.home_outlined),
      ),
      onSaved: (newValue) {
        _address = newValue;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
    );
  }

//Phone number TextFormField
  TextFormField buildPhoneNumberForm() {
    return TextFormField(
      style: const TextStyle(fontSize: 18),
      autocorrect: false,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          // labelText: 'Phone',
          hintStyle: const TextStyle(fontWeight: FontWeight.w300),
          hintText: 'Mobile number',
          suffixIcon: const Icon(Icons.tty_outlined),
          // Show country picker
          prefixIcon: Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                showCountryPicker(
                  context: context,
                  countryListTheme:
                      const CountryListThemeData(bottomSheetHeight: 400),
                  onSelect: (value) {
                    setState(() {
                      selectedCountry = value;
                    });
                    // print('Select country: ${country.displayName}');
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )),
      onSaved: (newValue) {
        _phoneNumber = newValue;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
          removeError(error: kInvalidPhoneNumberError);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        } else if (value.length < 10) {
          addError(error: kInvalidPhoneNumberError);
        }
        return null;
      },
    );
  }
}
