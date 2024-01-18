import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isOtherTabSelected = false;
  final List<TabList> _tabList = [
    TabList(
        isSelected: false,
        answer:
            'ans 1 is a large text need to check if the text is too large is text is visible ans 1 is a large text need to check '),
    TabList(isSelected: false, answer: 'ans 2'),
    TabList(isSelected: false, answer: 'ans 3'),
    TabList(isSelected: false, answer: 'ans 4'),
    TabList(isSelected: false, answer: 'ans 5'),
    TabList(isSelected: false, answer: 'ans 6'),
    TabList(isSelected: false, answer: 'ans 7'),
    TabList(isSelected: false, answer: 'ans 8'),
  ];
  final TextEditingController _otherFieldController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  _resetData() {
    _companyController.clear();
    _designationController.clear();
    _otherFieldController.clear();
    _nameController.clear();
    _contactNoController.clear();
    _emailController.clear();
    for (int i = 0; i < _tabList.length; i++) {
      if (_tabList[i].isSelected) {
        _tabList[i].isSelected = false;
      }
    }
    _isOtherTabSelected = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                _buildTabs(context, orientation),
                _buildUserDetailForm(context),
                _buildSubmitButton(context, orientation),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTabs(BuildContext context, Orientation orientation) {
    return Column(
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            ..._tabList.map<Widget>((element) {
              return InkWell(
                onTap: () {
                  setState(() {});
                  if (element.isSelected) {
                    element.isSelected = false;
                  } else {
                    element.isSelected = true;
                  }
                },
                child: Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: element.isSelected ? Colors.green : Colors.blueGrey,
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.sp, vertical: 8.sp),
                      child: Text(
                        element.answer,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {});
                _isOtherTabSelected = !_isOtherTabSelected;
              },
              child: Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _isOtherTabSelected ? Colors.green : Colors.grey,
                  ),
                  child: Center(
                    child: Text(
                      'Other',
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            _isOtherTabSelected
                ? Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Other Field',
                        labelText: 'Other',
                        border: OutlineInputBorder(),
                      ),
                      controller: _otherFieldController,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildUserDetailForm(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: 'Enter name ',
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                controller: _contactNoController,
                // maxLength: 10,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: const InputDecoration(
                  hintText: 'Enter Phone Number ',
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            Expanded(
              child: TextField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                controller: _designationController,
                decoration: const InputDecoration(
                  hintText: 'Enter Designation',
                  labelText: 'Designation',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: _companyController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: 'Enter Company',
                  labelText: 'Company',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            Expanded(
              child: TextField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter Email',
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(width: 20.w),
            const Spacer()
          ],
        ),
        SizedBox(height: 30.h),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context, Orientation orientation) {
    return SizedBox(
      width: 150.w,
      height: orientation == Orientation.landscape ? 50.h : 50.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange, elevation: 0),
        onPressed: () {
          _sendWhatsappMessage(
            headerText: 'headerText',
            bodyText: 'bodyText',
            phoneNumber: _contactNoController.text,
          );
          _submitUserSelectedData();
        },
        child: Text(
          'Submit',
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      ),
    );
  }

  _submitUserSelectedData() {
    List exhibitionData = [];
    for (int i = 0; i < _tabList.length; i++) {
      if (_tabList[i].isSelected) {
        exhibitionData.add(_tabList[i].answer);
      }
    }

    if (_otherFieldController.text.isNotEmpty &&
        _otherFieldController.text != null &&
        _isOtherTabSelected) {
      exhibitionData.add(_otherFieldController.text);
    }
    if (exhibitionData.isEmpty) {
      setState(() {});
      _dialogWidget(
        text: 'Please select minimum 1 tab',
        context: context,
      );
    } else if (_nameController.text.isEmpty ||
        _contactNoController.text.isEmpty ||
        _designationController.text.isEmpty ||
        _companyController.text.isEmpty ||
        _emailController.text.isEmpty) {
      setState(() {});
      _dialogWidget(
        text: 'Please fill all the fields',
        context: context,
      );
    } else if (_contactNoController.text.length != 10) {
      _dialogWidget(
        text: 'Phone number should be of 10 digit',
        context: context,
      );
    } else {
      ApiServices().submitExhibitionForm(
        exhibitionFormData: exhibitionData,
        name: _nameController.text,
        contact: _contactNoController.text,
        designation: _designationController.text,
        company: _companyController.text,
        context: context,
      );
      _resetData();
    }
  }

  Future<void> _sendWhatsappMessage({
    required String headerText,
    required String bodyText,
    required String? phoneNumber,
  }) async {
    final dio = Dio();
    String token =
        "EAADYkutjnqUBOxVgkKNbhSu1mhJPyzqwAm2RDWjF5WQ7fOkgjFINJ5lOkfsMFg0myYZB5mieDSbSis0Q2XgIbZB635gKqN9A5Ie8SqxcoB7t82D3QjLfytJrGKsSBNIAXIW3FZBXvjRdB1wdtPZBv6S0rEyxb0rspwcFwMeBTAkeRxaAlR1nZCjzAKeMxcKNiqCgLpcSf2wtkXpp64iAZD";

    try {
      final response = await dio.post(
        'https://graph.facebook.com/v18.0/218006251391820/messages',
        data: {
          "messaging_product": "whatsapp",
          "recipient_type": "individual",
          "to": '91$phoneNumber',
          "type": "template",
          "template": {
            "name": "exhibition_app",
            "language": {"code": "en_US"},
            "components": [
              {
                "type": "header",
                "parameters": [
                  {"type": "text", "text": headerText}
                ]
              },
              {
                "type": "body",
                "parameters": [
                  {"type": "text", "text": bodyText}
                ]
              }
            ]
          }
        },
        options: Options(
          headers: {"authorization": "Bearer $token"},
        ),
      );
      debugPrint('response : ${response.data}');
    } catch (e) {
      debugPrint('catch : $e');
    }
  }

  _dialogWidget({
    required String text,
    required BuildContext context,
  }) {
    return BotToast.showText(
      text: text,
      align: Alignment.center,
    );
  }
}

class TabList {
  bool isSelected;
  final String answer;

  TabList({
    required this.isSelected,
    required this.answer,
  });
}
