// For phone number Authentication without the use of emailPassword Authentication

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:get/get.dart';

import 'package:food_app/providers/bottom_sheet_provider.dart';
import 'package:food_app/screens/tab.dart';

FirebaseAuth firebase = FirebaseAuth.instance;

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  String? otpCode;
  String? firstName;
  final String verificationId = Get.arguments[0];

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _signIn() {
    focusNode.unfocus();
    formKey.currentState!.validate();

    if (otpCode != null) {
      verifyOtp(verificationId, otpCode!);
    } else {
      _showSnackBar('Enter 6 digit code sent to your phone number');
    }
  }

//to verify phone number
  void verifyOtp(String verificationId, String userOtp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOtp,
      );

      User? user = (await firebase.signInWithCredential(credential)).user;
      _storeUserData(user);

      if (user != null) {
        // to show bottom sheet when users sign up for the first time
        ref.read(bottomSheetProvider.notifier).showBottomSheet();

        // takes users to the tabscreen
        Get.to(const TabScreen());
        // if(mounted){}
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (ctx) => const TabScreen()));
      }
    } on FirebaseAuthException catch (error) {
      _showSnackBar(error.code);
    }
  }

//To store userData on firebase firestore
  void _storeUserData(User? user) async {
    // final user = firebase.currentUser;
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
      'firstName': firstName,
    });
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

    final focusedBorderColor = Theme.of(context).colorScheme.tertiary;
    final fillColor =
        Theme.of(context).colorScheme.onBackground.withOpacity(0.3);
    final borderColor = Theme.of(context).colorScheme.primary;

    final defaultPinTheme = PinTheme(
      width: 10 * size.width / 100,
      height: 7 * size.height / 100,
      textStyle: const TextStyle(
        fontSize: 22,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
    );

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'OTP Verification',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                SizedBox(
                  height: 1 * size.height / 100,
                ),
                Text(
                  'We sent your verification code to +234 81***',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.5),
                      ),
                ),
                SizedBox(
                  height: 1 * size.height / 100,
                ),
                buildTimer(
                  Theme.of(context).colorScheme.error,
                ),
                SizedBox(
                  height: 4 * size.height / 100,
                ),
                Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                          // Specify direction if desired
                          textDirection: TextDirection.ltr,
                          child: Pinput(
                            length: 6,
                            controller: pinController,
                            focusNode: focusNode,
                            androidSmsAutofillMethod:
                                AndroidSmsAutofillMethod.smsUserConsentApi,
                            listenForMultipleSmsOnAndroid: true,
                            defaultPinTheme: defaultPinTheme,
                            separatorBuilder: (index) => SizedBox(
                              width: 4 * size.width / 100,
                            ),

                            validator: (value) {
                              return value == otpCode
                                  ? null
                                  : 'Pin is incorrect';
                            },
                            // onClipboardFound: (value) {
                            //   debugPrint('onClipboardFound: $value');
                            //   pinController.setText(value);
                            // },
                            hapticFeedbackType: HapticFeedbackType.lightImpact,
                            onCompleted: (pin) {
                              setState(() {
                                otpCode = pin;
                              });

                              // debugPrint('onCompleted: $pin');
                            },
                            onChanged: (value) {
                              debugPrint('onChanged: $value');
                            },
                            cursor: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 9),
                                  width: 10,
                                  height: 1,
                                  color: focusedBorderColor,
                                ),
                              ],
                            ),
                            focusedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: focusedBorderColor),
                              ),
                            ),
                            submittedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                color: fillColor,
                                borderRadius: BorderRadius.circular(19),
                                border: Border.all(color: focusedBorderColor),
                              ),
                            ),
                            errorPinTheme: defaultPinTheme.copyBorderWith(
                              border: Border.all(color: Colors.redAccent),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4 * size.height / 100,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn't get OTP? ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground
                                        .withOpacity(0.5),
                                  ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                ' Resend code',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4 * size.height / 100,
                        ),
                        ElevatedButton(
                          onPressed: _signIn,
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                              Size.fromWidth(60 * size.width / 100),
                            ),
                          ),
                          child: const Text('Continue'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildTimer(Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: const Duration(seconds: 30),
          builder: (_, dynamic value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
