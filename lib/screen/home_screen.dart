import 'dart:developer';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isOtherTabSelected = false;
  final List<TabList> _tabList = [
    TabList(name: 'tab 1', isSelected: false),
    TabList(name: 'tab 2', isSelected: false),
    TabList(name: 'tab 3', isSelected: false),
    TabList(name: 'tab 4', isSelected: false),
  ];
  final TextEditingController _otherFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: InkWell(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 2,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _tabList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
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
                            height: MediaQuery.sizeOf(context).height / 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _tabList[index].isSelected
                                  ? Colors.green
                                  : Colors.red,
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
                  SizedBox(height: MediaQuery.sizeOf(context).height / 100),
                  InkWell(
                    onTap: () {
                      setState(() {});
                      _isOtherTabSelected = !_isOtherTabSelected;
                    },
                    child: Container(
                      height: MediaQuery.sizeOf(context).height / 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: _isOtherTabSelected ? Colors.green : Colors.red,
                      ),
                      child: const Center(
                        child: Text(
                          'Other',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height / 100),
                  _isOtherTabSelected
                      ? TextField(
                          decoration: const InputDecoration(
                            hintText: 'Other Field',
                            border: OutlineInputBorder(),
                          ),
                          controller: _otherFieldController,
                        )
                      : const SizedBox(),
                  SizedBox(height: MediaQuery.sizeOf(context).height / 7),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          padding: const EdgeInsets.only(bottom: 25),
          width: MediaQuery.sizeOf(context).width / 2,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () {
              //TODO submit data on server or any storage

              var data = submitData();
              log('data List ${data.toString()}');
            },
            child: const Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  List<String> submitData() {
    List<String> dataList = [];
    for (int i = 0; i < _tabList.length; i++) {
      if (_tabList[i].isSelected) {
        dataList.add(_tabList[i].name);
      }
    }
    if (_otherFieldController.text.isNotEmpty &&
        _otherFieldController.text != null) {
      dataList.add(_otherFieldController.text);
    }
    return dataList;
  }
}

class TabList {
  final String name;
  bool isSelected;

  TabList({
    required this.name,
    required this.isSelected,
  });
}
