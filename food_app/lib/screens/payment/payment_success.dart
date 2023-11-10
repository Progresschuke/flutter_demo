import 'package:flutter/material.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({
    super.key,
    required this.reference,
    required this.message,
  });

  final String reference;
  final String message;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Status'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 4 * size.width / 100,
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/payment_successful.png',
                  height: 20 * size.height / 100,
                ),
                SizedBox(
                  height: 3 * size.height / 100,
                ),
                Text(
                  'Payment Successful',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                SizedBox(
                  height: 3 * size.height / 100,
                ),
                Text(
                  textAlign: TextAlign.center,
                  reference,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                SizedBox(
                  height: 3 * size.height / 100,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                          Size.fromWidth(60 * size.width / 100)),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/a');
                    },
                    child: const Text('Back to Home'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
