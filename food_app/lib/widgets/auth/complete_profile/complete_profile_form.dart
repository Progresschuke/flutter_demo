import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/providers/bottom_sheet_provider.dart';
import 'package:food_app/screens/tab.dart';

import 'package:food_app/constant/form_constants.dart';
import 'package:food_app/widgets/auth/form_error.dart';

final firebase = FirebaseAuth.instance;

class CompleteProfileForm extends ConsumerStatefulWidget {
  const CompleteProfileForm({super.key});

  @override
  ConsumerState<CompleteProfileForm> createState() =>
      _CompleteProfileFormState();
}

class _CompleteProfileFormState extends ConsumerState<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  String? _firstName = '';
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

// To save userData on firebase firestore
  void _signIn() async {
    FocusScope.of(context).unfocus();
    final user = firebase.currentUser;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // to store user credentials
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'firstName': _firstName,
        'lastName': _lastName,
        'address': _address,
        'phone': '+${selectedCountry.phoneCode} $_phoneNumber',
      });

      if (mounted) {}
      // to show bottom sheet when users sign up for the first time
      ref.read(bottomSheetProvider.notifier).showBottomSheet();

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const TabScreen()),
      );
    }
  }

  // to show snackbar message based on the state of authentication
  // void _showSnackBar(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(SnackBar(content: Text(message)));
  // }

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
              onPressed: _signIn,
              child: const Text('Sign In'))
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
        _firstName = newValue;
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
        } else if (value.length < 2) {
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
        } else if (value.length < 2) {
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
