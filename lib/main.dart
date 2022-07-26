import 'package:architecture/models/group.dart';
import 'package:architecture/view/HomePage_without_groups.dart';
import 'package:architecture/view/error_page.dart';
import 'package:architecture/view/home.dart';
import 'package:architecture/view/private_profile_page.dart';
import 'package:architecture/view/splash_page.dart';
import 'package:architecture/viewModel/cardsHandler.dart';
import 'package:architecture/viewModel/chats_list.dart';
import 'package:architecture/viewModel/match_list.dart';
import 'package:architecture/viewModel/userViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';
import 'view/chat_page.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('run');
    return MultiProvider(providers: [
    ChangeNotifierProvider<UserViewModel>(create: (context) => UserViewModel()),
    ChangeNotifierProvider(create: (context) => CardsHandler()),
    ChangeNotifierProvider(create: (context) => MatchList()),
    ChangeNotifierProvider(create: (context) => ChatsList())], 
      child: Builder(builder: (context) {
        return MaterialApp(
          navigatorKey: Provider.of<UserViewModel>(context).rootNavigatorKey,
          initialRoute: '/',
          onGenerateRoute: (setting) {
            switch (setting.name) {
              case '/':
                return MaterialPageRoute(
                    builder: (context) => const SplashPage());
              case '/home':
             final MyUser user =  context.read<UserViewModel>().user;
             final String uId = user.uId;
             final Group currentGroup = user.myGroups!.last;
             context.read<CardsHandler>().initalDataForNewStackOfCards(group: currentGroup,uId: uId);
             context.read<ChatsList>().initializeData(uId);
             context.read<MatchList>().initializeData(uId);
                  return MaterialPageRoute(
                      builder: (context) => const HomePage());
              case '/withoutGroups' :
                  return MaterialPageRoute(
                      builder: (context) => const HomePageWithoutGroups());
              case '/editing':
                return MaterialPageRoute(
                    builder: (context) => const EditingPage());
              case '/chat':
                return MaterialPageRoute(builder: (context) => const ChatPage());
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
