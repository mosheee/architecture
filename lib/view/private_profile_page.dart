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
          final name = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (newContext) =>
                      ChangeNotifierProvider<UserModel>.value(
                        value: UserModel(),
                        child: EditingPage(),
                      )));
          context.read<UserModel>().changeUserName(name);
        },
        child: Consumer<UserModel>(builder: (context, user, child) {
          print('selector');
          return Text(user.userName);
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
    return Material(
      child: SafeArea(
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
                    Navigator.pop(context,myController.text);
                  },
                  child: const Text('save'))
            ],
          ),
        ),
      ),
    );
  }
}
