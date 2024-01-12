import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  final db = FirebaseFirestore.instance;

  void submitExhibitionForm({
    exhibitionFormData,
    String? name,
    String? contact,
    String? designation,
    String? company,
    context,
  }) async {
    Map<String, dynamic> userDataList = {
      "name": name,
      "contact": contact,
      "designation": designation,
      "company": company,
    };
    Map<String, dynamic> exhibitionFormDataList = {
      "problem": exhibitionFormData,
      "user detail": userDataList,
    };

    try {
      await db.collection('ExhibitionForm').add(exhibitionFormDataList).then(
        (value) {
          log('exhibitionFormData : $value $exhibitionFormData');
        },
      );
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: const Text('Exhibition Form Submitted'),
            ),
          );
        },
      );
    } catch (e) {
      log('Exception $e');
    }
  }
}
