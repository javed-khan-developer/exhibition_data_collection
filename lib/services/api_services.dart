import 'dart:developer';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiServices {
  submitExhibitionForm({
    List<String>? exhibitionFormData,
    String? name,
    String? contact,
    String? designation,
    String? company,
    String? email,
    context,
  }) async {
    exhibitionFormData?.map((element) {
      debugPrint('element$element');
    });

    try {
      final response = await http.post(
        Uri.parse(
          'https://foodiisoft-v4.e-go.biz/feedback/public/api/feedback',
        ),
        body: {
          'name': name,
          'email': email,
          'phone_no': contact,
          'company': company,
          'designation': designation,
          'problem_statement': exhibitionFormData.toString()
        },
      );
      debugPrint('response data ${response.body}');
      debugPrint('response statusCode ${response.statusCode}');
      if (response.statusCode == 200) {
        final exhibitionModel = exhibitionModelFromJson(response.body);
        BotToast.showText(text: exhibitionModel.message ?? '');
      } else {
        BotToast.showText(text: 'Something went wrong');
      }
    } catch (e) {
      debugPrint('Exception $e');
    }
  }
}
// To parse this JSON data, do
//
//     final exhibitionModel = exhibitionModelFromJson(jsonString);

ExhibitionModel exhibitionModelFromJson(String str) =>
    ExhibitionModel.fromJson(json.decode(str));

String exhibitionModelToJson(ExhibitionModel data) =>
    json.encode(data.toJson());

class ExhibitionModel {
  final String? message;
  final int? flag;

  ExhibitionModel({
    this.message,
    this.flag,
  });

  factory ExhibitionModel.fromJson(Map<String, dynamic> json) =>
      ExhibitionModel(
        message: json["message"],
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "flag": flag,
      };
}
