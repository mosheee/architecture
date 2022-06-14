import 'package:architecture/models/user.dart';
import 'package:architecture/viewModel/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrivateProfilePage extends StatefulWidget {
  const PrivateProfilePage({Key? key}) : super(key: key);

  @override
  State<PrivateProfilePage> createState() => _PrivateProfilePageState();
}

class _PrivateProfilePageState extends State<PrivateProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          Provider.of<ViewModel>(context,listen: false).navigateToEditPage();
        },
        child: Selector<ViewModel,String>(
          selector: (_,userModel) => userModel.userName,
          builder: (context, userName, child) {
          return Text(userName);
        }),
      ),
    );
  }
}

class EditingPage extends StatefulWidget {
  const EditingPage({Key? key}) : super(key: key);

  @override
  State<EditingPage> createState() => _EditingPageState();
}

class _EditingPageState extends State<EditingPage> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('editingPage')),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                child: TextField(
                  controller: myController,
                ),
              ),
              TextButton(
                  onPressed: () {
                    // Navigator.pop(context,myController.text);
                    Provider.of<ViewModel>(context,listen: false).changeUserName(myController.text);
                  },
                  child: const Text('save'))
            ],
          ),
        ),
      ),
    );
  }
}
