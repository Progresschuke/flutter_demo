//Raw file using a streambuilder
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/widgets/profile/profile_stats/profile_stats_body.dart';

class ProfileStats extends StatelessWidget {
  const ProfileStats({
    super.key,
    // required this.title,
    // required this.stats,
  });

  // final String title;
  // final String stats;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    Size size = MediaQuery.of(context).size;

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc("$user!.uid")
            .snapshots(),
        builder: (ctx, docSnapshots) {
          if (docSnapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!docSnapshots.hasData) {
            return const Center(
              child: Text('Update your Profile'),
            );
          }
          if (docSnapshots.hasError) {
            return const Center(
              child: Text('Something went wrong...'),
            );
          }

          final userData = docSnapshots.data!.data();
          final username = '${userData!['firstName']} ${userData['lastName']}';
          final address = '${userData['address']}';
          final phone = '${userData['phone']}';

          return Container(
            padding: EdgeInsets.all(2 * size.height / 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProfileStatsBody(title: 'Name', stats: username),
                ProfileStatsBody(title: 'Adress', stats: address),
                ProfileStatsBody(title: 'Mobile No', stats: phone),
              ],
            ),
          );
        });
  }
}
