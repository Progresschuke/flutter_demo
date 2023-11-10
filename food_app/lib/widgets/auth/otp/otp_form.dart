import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

import 'package:food_app/providers/bottom_sheet_provider.dart';
import 'package:food_app/screens/tab.dart';

class OtpForm extends ConsumerStatefulWidget {
  const OtpForm({super.key});

  @override
  ConsumerState<OtpForm> createState() => _OtpBodyState();
}

class _OtpBodyState extends ConsumerState<OtpForm> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
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
    return Center(
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
                  return value == '222222' ? null : 'Pin is incorrect';
                },
                // onClipboardFound: (value) {
                //   debugPrint('onClipboardFound: $value');
                //   pinController.setText(value);
                // },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {
                  debugPrint('onCompleted: $pin');
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
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
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
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 4 * size.height / 100,
            ),
            ElevatedButton(
              onPressed: () {
                focusNode.unfocus();
                formKey.currentState!.validate();

                // to show bottom sheet when users sign up for the first time
                ref.read(bottomSheetProvider.notifier).showBottomSheet();

                // takes users to the tabscreen
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const TabScreen()));
              },
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
    );
  }
}
