import 'package:architecture/view/home.dart';
import 'package:architecture/viewModel/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: const HomePage()),);
  }
}

