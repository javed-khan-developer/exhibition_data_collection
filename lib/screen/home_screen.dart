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
    TabList(isSelected: false, answer: 'ans 2'),
    TabList(isSelected: false, answer: 'ans 1'),
    TabList(isSelected: false, answer: 'ans 3'),
    TabList(isSelected: false, answer: 'ans 4'),
  ];
  final TextEditingController _otherFieldController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();

  _resetData() {
    _companyController.clear();
    _designationController.clear();
    _otherFieldController.clear();
    _nameController.clear();
    _contactNoController.clear();
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 50),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              _buildTabs(context),
              _buildUserDetailForm(context),
              _buildSubmitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height / 5,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _tabList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _tabList.length,
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
        SizedBox(height: MediaQuery.sizeOf(context).height / 50),
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
                        border: OutlineInputBorder(),
                      ),
                      controller: _otherFieldController,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ],
    );
  }

  Widget _buildUserDetailForm(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.only(top: 28.0),
        child: ExpansionTile(
          title: const Text('User Detail'),
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          hintText: 'Enter name ',
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
                          hintText: 'Designation',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.sizeOf(context).width / 50),
                    Expanded(
                      child: TextField(
                        controller: _companyController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          hintText: 'Company',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height / 50),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 38.0),
      child: Container(
        padding: const EdgeInsets.only(bottom: 25),
        width: MediaQuery.sizeOf(context).width / 4,
        height: MediaQuery.sizeOf(context).height / 9,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          onPressed: () {
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
    if (exhibitionData.length < 3) {
      setState(() {});
      showDialog(
        context: context,
        builder: (context) {
          return _dialogWidget(
            text: 'Please select minimum 3 tabs ',
            context: context,
          );
        },
      );
    } else if (_nameController.text.isEmpty ||
        _contactNoController.text.isEmpty ||
        _designationController.text.isEmpty ||
        _companyController.text.isEmpty) {
      setState(() {});
      showDialog(
        context: context,
        builder: (context) {
          return _dialogWidget(
            text: 'Please fill all the fields',
            context: context,
          );
        },
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

  Dialog _dialogWidget({required String text, required BuildContext context}) {
    return Dialog(
      backgroundColor: Colors.red.shade500,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height / 8,
        width: MediaQuery.sizeOf(context).width / 4,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
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
