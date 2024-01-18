import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiServices {
  // final db = FirebaseFirestore.instance;
  final dio = Dio();

  Future<Response?> submitExhibitionForm({
    exhibitionFormData,
    String? name,
    String? contact,
    String? designation,
    String? company,
    context,
  }) async {
    // Map<String, dynamic> userDataList = {
    //   "name": name,
    //   "contact": contact,
    //   "designation": designation,
    //   "company": company,
    // };
    // Map<String, dynamic> exhibitionFormDataList = {
    //   "problem": exhibitionFormData,
    //   "user detail": userDataList,
    // };

    try {
      // await db.collection('ExhibitionForm').add(exhibitionFormDataList).then(
      //   (value) {
      //     debugPrint('exhibitionFormData : $value $exhibitionFormData');
      //   },
      // );
      final response = await dio.post(
        'url',
        data: {
          "problem statement": "",
          "name": "",
          "phone number": "",
          "designation": "",
          "company": "",
          "email": ""
        },
        options: Options(
          headers: {},
        ),
      );
      if (response.statusCode == 200) {
        BotToast.showText(text: 'Thank you for visiting us!');
      } else {
        BotToast.showText(text: 'Something went wrong');
      }
    } catch (e) {
      log('Exception $e');
    }
  }
}
