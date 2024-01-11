import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  final db = FirebaseFirestore.instance;

  void submitExhibitionForm({tabCapturedData}) async {
    try {
      await db.collection('ExhibitionForm').add(tabCapturedData).then(
        (value) {

          log('answers : $value $tabCapturedData');
        },
      );
    } catch (e) {
      log('Exception ${e}');
    }
  }

  void submitUserDetails({userDetailsData}) async {
    try {
      await db.collection('UserDetailForm').add(userDetailsData).then(
            (value) => log('userDetail : $value $userDetailsData'),
          );
    } catch (e) {
      log('Exception $e');
    }
  }
}
