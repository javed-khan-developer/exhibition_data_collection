import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
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
          debugPrint('exhibitionFormData : $value $exhibitionFormData');
        },
      );

      BotToast.showText(text: 'Thank you for visiting us!');
    } catch (e) {
      log('Exception $e');
    }
  }
}
