import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/firebase_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isOtherTabSelected = false;
  final List<TabList> _tabList = [
    TabList(isSelected: false, answer: 'ans 1'),
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
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 50),
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
        SizedBox(
          height: orientation == Orientation.landscape ? 210 : 200,
          child: GridView.builder(
            itemCount: _tabList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 2.5,
            ),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(

                onTap: () {
                  setState(() {});
                  if (_tabList[index].isSelected) {
                    _tabList[index].isSelected = false;
                  } else {
                    _tabList[index].isSelected = true;
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:
                        _tabList[index].isSelected ? Colors.green : Colors.grey,
                  ),
                  child: Center(
                    child: Text(
                      _tabList[index].answer,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 50),
        Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {});
                _isOtherTabSelected = !_isOtherTabSelected;
              },
              child: Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.sizeOf(context).width / 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _isOtherTabSelected ? Colors.green : Colors.grey,
                  ),
                  child: const Center(
                    child: Text(
                      'Other',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: MediaQuery.sizeOf(context).width / 50),
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
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildUserDetailForm(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
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
            SizedBox(width: MediaQuery.sizeOf(context).width / 50),
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
        SizedBox(height: MediaQuery.sizeOf(context).height / 50),
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
            SizedBox(width: MediaQuery.sizeOf(context).width / 50),
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
        SizedBox(height: MediaQuery.sizeOf(context).height / 50),
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
            SizedBox(width: MediaQuery.sizeOf(context).width / 50),
            const Spacer()
          ],
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context, Orientation orientation) {
    return Padding(
      padding: const EdgeInsets.only(top: 38.0),
      child: Container(
        padding: const EdgeInsets.only(bottom: 25),
        width: MediaQuery.sizeOf(context).width / 4,
        height: orientation == Orientation.landscape ? 90 : 90,
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
          child: const Text(
            'Submit',
            style: TextStyle(color: Colors.white),
          ),
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
      FirebaseServices().submitExhibitionForm(
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
