import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screens/auth/sign_in.dart';
import 'package:food_app/widgets/profile/image_input/profile_image_input.dart';
import 'package:food_app/widgets/profile/profile_stats/profile_stats.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  File? _selectedImage;
  final user = FirebaseAuth.instance.currentUser;

  void _saveProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('${user!.uid}.jpg');

      await storageRef.putFile(_selectedImage!);
      final imageUrl = await storageRef.getDownloadURL();
      final data = {'imageUrl': imageUrl};

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
          data,
          SetOptions(
              merge:
                  true)); // to merge the imageUrl to the previous user data without deletion
    } on FirebaseAuthException catch (error) {
      _showSnackBar(error.code);
    }
  }

  // to show snackbar message based on the state of authentication
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void _logOut() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const SignInScreen()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 34 * size.height / 100,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/profile_background.jpg',
                      fit: BoxFit.fitWidth,
                      width: double.infinity,
                      height: 20 * size.height / 100,
                    ),
                    ImageFiltered(
                      imageFilter: ImageFilter.blur(
                          sigmaX: 5.0,
                          sigmaY:
                              5.0), // Adjust sigmaX and sigmaY for desired blur intensity
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: 5.0,
                            sigmaY:
                                5.0), // Duplicate the blur filter for better effect
                        child: Container(
                          width: double.infinity,
                          height: 20 * size.height / 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(
                                    .6), // Adjust opacity for desired effect
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 3,
                        left: 80,
                        child: ProfileImageInput(
                            onSaveProfile: _saveProfile,
                            onPickImage: (pickImage) {
                              _selectedImage = pickImage;
                            }))
                  ],
                ),
              ),
              const ProfileStats(),
              ElevatedButton.icon(
                  onPressed: _logOut,
                  icon: const Icon(Icons.logout_outlined),
                  label: const Text('log out'))
            ],
          ),
        ),
      ),
    );
  }
}
