import 'dart:developer';

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
    TabList(name: 'tab 1', isSelected: false, answer: 'ans 1'),
    TabList(name: 'tab 2', isSelected: false, answer: 'ans 2'),
    TabList(name: 'tab 3', isSelected: false, answer: 'ans 3'),
    TabList(name: 'tab 4', isSelected: false, answer: 'ans 4'),
    TabList(name: 'tab 4', isSelected: false, answer: 'ans 4'),
    TabList(name: 'tab 4', isSelected: false, answer: 'ans 4'),
    TabList(name: 'tab 4', isSelected: false, answer: 'ans 4'),
    TabList(name: 'tab 4', isSelected: false, answer: 'ans 4'),
    TabList(name: 'tab 4', isSelected: false, answer: 'ans 4'),
    TabList(name: 'tab 4', isSelected: false, answer: 'ans 4'),
  ];
  final TextEditingController _otherFieldController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 50),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              _buildUserDetailForm(context),
              _buildTabs(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: const Text('Exhibition Form'),
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 8,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _tabList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 2,
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
                          color: _tabList[index].isSelected
                              ? Colors.green
                              : Colors.grey,
                        ),
                        child: Center(
                          child: Text(
                            _tabList[index].name,
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
                        height: MediaQuery.sizeOf(context).height / 11,
                        width: MediaQuery.sizeOf(context).width / 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                              _isOtherTabSelected ? Colors.green : Colors.grey,
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
              SizedBox(height: MediaQuery.sizeOf(context).height / 10),
              _buildSubmitButton(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserDetailForm(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: true,
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
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 25),
      width: MediaQuery.sizeOf(context).width / 4,
      height: MediaQuery.sizeOf(context).height / 9,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
        onPressed: () {
          Map<String, dynamic> data = _submitUserSelectedData();
          FirebaseServices().submitExhibitionForm(tabCapturedData: data);
          log('data List ${data.toString()}');
        },
        child: const Text(
          'Submit',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Map<String, dynamic> _submitUserSelectedData() {
    Map<String, dynamic> dataList = {};
    for (int i = 0; i < _tabList.length; i++) {
      if (_tabList[i].isSelected) {
        dataList[_tabList[i].name] = _tabList[i].answer;
      }
    }

    if (_otherFieldController.text.isNotEmpty &&
        _otherFieldController.text != null &&
        _isOtherTabSelected) {
      dataList['other'] = _otherFieldController.text;
    }
    if (dataList.length < 3) {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: const Text('please select minimum 3 tabs'),
              ),
            );
          });
    } else {}
    return dataList;
  }
}

class TabList {
  final String name;
  bool isSelected;
  final String answer;

  TabList({
    required this.name,
    required this.isSelected,
    required this.answer,
  });
}
