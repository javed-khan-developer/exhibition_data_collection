import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: InkWell(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 40),
            child: Column(
              children: [
                TextField(
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'Enter name ',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height / 50),
                TextField(
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  controller: _contactNoController,
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    hintText: 'Enter Phone Number ',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height / 50),
                TextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  controller: _designationController,
                  decoration: const InputDecoration(
                    hintText: 'Designation',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height / 50),
                TextField(
                  controller: _companyController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'Company',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height / 25),
                Container(
                  padding: const EdgeInsets.only(bottom: 25),
                  width: MediaQuery.sizeOf(context).width / 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange),
                    onPressed: () {
                      _submitUserDetail();
                      //TODO submit data on server or any storage
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitUserDetail() {
    if (_nameController.text.isEmpty ||
        _contactNoController.text.isEmpty ||
        _designationController.text.isEmpty ||
        _companyController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: const Text('please fill all the fields'),
              ),
            );
          });
    }
  }
}
