import 'package:architecture/view/error_page.dart';
import 'package:architecture/view/home.dart';
import 'package:architecture/view/private_profile_page.dart';
import 'package:architecture/view/splash_page.dart';
import 'package:architecture/viewModel/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//            suggested architecture
// we describe here our architecture and a several common cases to prove the architecture&stateManagement vision

// case 1 : manage variebles across the app (update ui, get var from server,save var in cach or dataBase) :
// a - initail UserModel first
// b - call getCard() , getUser().  this functions inital the variebles _cards and user.
// c - we wrap with selector ui packages. every package get rebuild if the varieble which selector listen to get change.

// case 2 : activate function and get data from UserModel() from another route.
// a - EditingPage() is in another route. we activate the function changeUserName from UserModel
// case 3 : manage states of widgets
// a - we manage the state of the card's stack with the enums CardState.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('run');
    return ChangeNotifierProvider(
      create: (context) => ViewModel(),
      child: Builder(builder: (context) {
        return MaterialApp(
          navigatorKey: Provider.of<ViewModel>(context).rootNavigatorKey,
          initialRoute: '/',
          onGenerateRoute: (setting) {
            print(setting.name);
            switch (setting.name) {
              case '/':
                return MaterialPageRoute(
                    builder: (context) => const SplashPage());
              case '/home':
                return MaterialPageRoute(
                    builder: (context) => const HomePage());
              case '/editing':
                return MaterialPageRoute(
                    builder: (context) => const EditingPage());
              case '/error':
              default:
                return MaterialPageRoute(
                    builder: (context) => const ErrorPage());
            }
          },
        );
      }),
    );
  }
}
