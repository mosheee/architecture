import 'package:architecture/models/card.dart';
import 'package:architecture/models/user.dart';
import 'package:architecture/services/http.dart';
import 'package:flutter/cupertino.dart';

import '../models/group.dart';

class UserViewModel extends ChangeNotifier {
  final Repository _repository = Repository();
  GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "root navigation key");

  late MyUser? _user;
  get user => _user;

  UserViewModel() {
    getUser();
  }

  getUser() async {
    _user = await _repository.getUser();
    print(_user);
    if(_user != null){
     if(_user!.myGroups!.isEmpty){
       navigateToHomePageWithoutGroups();
     }else{
      navigateToHomePage(); 
     }
    }else{
    navigateToErrorPage();
    }
  }

  saveUserChanges(String newUserName) async {
    _user!.name = newUserName;
    rootNavigatorKey.currentState!.pop();
    notifyListeners();
  }



  navigateToHomePage() {
    if (_user!.myGroups!.isEmpty) {
      navigateToHomePageWithoutGroups();
    } else {
      rootNavigatorKey.currentState!.pushReplacementNamed('/home');
    }
  }

  navigateToErrorPage() => rootNavigatorKey.currentState!.pushNamed('/error');
  navigateToHomePageWithoutGroups() =>
      rootNavigatorKey.currentState!.pushNamed('/withoutGroups');

  navigateToEditPage() => rootNavigatorKey.currentState!.pushNamed('/editing');
}

//enum

enum ScaffoldMessage { newMessage, non }

class SwipeId {
  String? id;
  bool userBelongToSomeGroup;
  SwipeId({this.id, required this.userBelongToSomeGroup});
}
