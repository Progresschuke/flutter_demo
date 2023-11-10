import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:food_app/logo/logo.dart';
import 'package:food_app/screens/payment/payment_failure.dart';
import 'package:food_app/screens/payment/payment_success.dart';
import 'package:intl/intl.dart';

String paystackPublicKey = '${dotenv.env['APIKEY']}';

class ProceedPayment extends StatefulWidget {
  const ProceedPayment({super.key, required this.amountTag});

  final String amountTag;

  @override
  State<ProceedPayment> createState() => _ProceedPaymentState();
}

class _ProceedPaymentState extends State<ProceedPayment> {
  TextEditingController amountController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final plugin = PaystackPlugin();

  final CheckoutMethod _method = CheckoutMethod.card;
  bool _inProgress = false;
  String? _cardNumber;
  String? _cvv;
  int? _expiryMonth;
  int? _expiryYear;

  @override
  void initState() {
    plugin.initialize(publicKey: paystackPublicKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final value = NumberFormat("#,###");
    final amount = double.parse(widget.amountTag);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(centerTitle: true, title: const Text('Proceed Payment')),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onBackground),
                  initialValue: value.format(amount),
                  // controller: amountController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Amount';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      prefix: Text('NGN '),
                      hintText: '1000',
                      labelText: 'Amount',
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 3 * size.height / 100,
                ),

                //email Controller
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onBackground),
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      hintText: 'example@gmail.com',
                      labelText: 'Email',
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 5 * size.height / 100,
                ),
                Builder(
                  builder: (context) {
                    return _inProgress
                        ? Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            child: Platform.isIOS
                                ? const CupertinoActivityIndicator()
                                : const CircularProgressIndicator(),
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: _getPlatformButton(
                                    'Checkout',
                                    () => _handleCheckout(context),
                                  ),
                                ),
                              ),
                            ],
                          );
                  },
                ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _handleCheckout(BuildContext context) async {
    setState(() => _inProgress = true);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
    }

    Charge charge = Charge()
      ..currency = 'NGN'
      ..amount =
          double.parse(widget.amountTag).toInt() * 100 // In base currency
      ..email = emailController.text
      ..card = _getCardFromUI();

    charge.reference = _getReference();

    try {
      CheckoutResponse response = await plugin.checkout(
        context,
        method: _method,
        charge: charge,
        fullscreen: true,
        logo: const Logo(),
      );

      if (response.status == true) {
        setState(() => _inProgress = false);
        _updateSuccessfulStatus(response.reference, response.message);
      }

      if (response.status == false) {
        setState(() => _inProgress = false);
        _updateFailedStatus(response.reference, '$response.reference');
      }
    } catch (e) {
      setState(() => _inProgress = false);
      _showMessage("An error occured! Try again later..");
      rethrow;
    }
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  PaymentCard _getCardFromUI() {
    // Using just the must-required parameters.
    return PaymentCard(
      number: _cardNumber,
      cvc: _cvv,
      expiryMonth: _expiryMonth,
      expiryYear: _expiryYear,
    );
  }

  Widget _getPlatformButton(String string, Function() function) {
    // is still in progress
    Widget widget;
    if (Platform.isIOS) {
      widget = CupertinoButton(
        onPressed: function,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        color: CupertinoColors.activeBlue,
        child: Text(
          string,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else {
      widget = ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.primary)),
        onPressed: function,
        child: Text(
          string.toUpperCase(),
          style: TextStyle(
              fontSize: 17.0,
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold),
        ),
      );
    }
    return widget;
  }

  // _updateStatus(String? reference, String message) {
  //   _showMessage('Reference: $reference \n Response: $message',
  //       const Duration(seconds: 7));
  // }

  _updateSuccessfulStatus(String? reference, String message) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (ctx) => PaymentSuccess(
          reference: reference!,
          message: message,
        ),
      ),
      ModalRoute.withName('/'),
    );
  }

  _updateFailedStatus(String? reference, String message) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (ctx) => PaymentFailure(
          message: message,
        ),
      ),
      ModalRoute.withName('/'),
    );
  }

  _showMessage(String message,
      [Duration duration = const Duration(seconds: 4)]) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: duration,
      action: SnackBarAction(
          label: 'CLOSE',
          onPressed: () =>
              ScaffoldMessenger.of(context).removeCurrentSnackBar()),
    ));
  }
}

CheckoutMethod _parseStringToMethod(String string) {
  CheckoutMethod method = CheckoutMethod.card;

  return method;
}
