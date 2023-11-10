import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/widgets/auth/complete_profile/complete_profile_body.dart';

class CompleProfile extends StatelessWidget {
  const CompleProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
            onWillPop: () async {
              FirebaseAuth.instance.currentUser!.delete();
              return true;
            },
            child: const CompleteProfileBody()));
  }
}
