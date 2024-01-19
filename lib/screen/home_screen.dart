import 'package:bot_toast/bot_toast.dart';
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
  bool _isLoading = false;
  final List<TabList> _tabList = [
    TabList(
        isSelected: false,
        answer:
            'ans 1 is a large text need to check if the text is too large is text is visible ans 1 is a large text need to check ans 1 is a large text need to check if the text is too large is text is'),
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
      body: OrientationBuilder(builder: (
        context,
        orientation,
      ) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: !_isLoading
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.sp, vertical: 16.sp),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        child: Wrap(
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
                                  height: orientation == Orientation.landscape
                                      ? 120.h
                                      : 80.h,
                                  width: orientation == Orientation.landscape
                                      ? 165.w
                                      : 163.w,
                                  decoration: element.isSelected
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.green,
                                        )
                                      : BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black)),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.sp, vertical: 8.sp),
                                      child: Text(
                                        element.answer,
                                        style: TextStyle(
                                          color: element.isSelected
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: orientation ==
                                                  Orientation.landscape
                                              ? 4.7.sp
                                              : 7.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {});
                              _isOtherTabSelected = !_isOtherTabSelected;
                            },
                            child: Expanded(
                              child: Container(
                                height: orientation == Orientation.landscape
                                    ? 75.h
                                    : 40.h,
                                width: orientation == Orientation.landscape
                                    ? 60.w
                                    : 80.w,
                                decoration: _isOtherTabSelected
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.green,
                                      )
                                    : BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.sp, vertical: 8.sp),
                                    child: Text(
                                      'Other',
                                      style: TextStyle(
                                        color: _isOtherTabSelected
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize:
                                            orientation == Orientation.landscape
                                                ? 4.7.sp
                                                : 7.sp,
                                      ),
                                    ),
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
                      SizedBox(
                        height:
                            orientation == Orientation.landscape ? 40.h : 40.h,
                        width: orientation == Orientation.landscape
                            ? 100.w
                            : 100.w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange, elevation: 0),
                          onPressed: () {
                            _submitUserSelectedData();
                          },
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: orientation == Orientation.landscape
                                  ? 4.7.sp
                                  : 7.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
        );
      }),
    );
  }

  _submitUserSelectedData() {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    List<String> exhibitionData = [];
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
        _companyController.text.isEmpty) {
      setState(() {});
      _dialogWidget(
        text: 'Please fill all the fields',
        context: context,
      );
    } else if (_contactNoController.text.isNotEmpty &&
        _contactNoController.text.length != 10) {
      _dialogWidget(
        text: 'Phone number should be of 10 digit',
        context: context,
      );
    } else if (_emailController.text.isNotEmpty &&
        !regex.hasMatch(_emailController.text)) {
      _dialogWidget(
        text: 'Phone enter a valid email address',
        context: context,
      );
    } else {
      _isLoading = true;
      ApiServices().submitExhibitionForm(
        exhibitionFormData: exhibitionData,
        name: _nameController.text,
        contact: _contactNoController.text,
        designation: _designationController.text,
        company: _companyController.text,
        email: _emailController.text,
        context: context,
      );
      _resetData();
      _isLoading = false;
    }
  }

  _dialogWidget({
    required String text,
    required BuildContext context,
  }) {
    return BotToast.showText(
      text: text,
      align: Alignment.center,
      duration: const Duration(seconds: 2),
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
