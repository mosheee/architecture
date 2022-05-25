import 'package:architecture/viewModel/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SwitchGroupPage extends StatelessWidget {
  const SwitchGroupPage({ Key? key }) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Selector<UserModel,String>(
          selector: (_,userModel) => userModel.userName,
          builder: (context,name,child){
            print('run');
            return Text(name);
          },),
      ),
    );
  }
}