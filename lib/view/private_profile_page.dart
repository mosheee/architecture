import 'package:architecture/models/user.dart';
import 'package:architecture/viewModel/userViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class PrivateProfilePage extends StatelessWidget {
  const PrivateProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyUser user = context.read<UserViewModel>().user;
    return Center(
      child: GestureDetector(
        onTap: () async {
          Provider.of<UserViewModel>(context,listen: false).navigateToEditPage();
        },
        child: Text(user.name)
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
                    context.read<UserViewModel>().saveUserChanges(myController.text);
                  },
                  child: const Text('save'))
            ],
          ),
        ),
      ),
    );
  }
}
