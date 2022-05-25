import 'package:architecture/models/card.dart';
import 'package:architecture/models/user.dart';

class HttpRequest {
  Future<MyUser> getUser() async {
    return await Future.delayed(const Duration(seconds: 2), () {
      return MyUser(
        name: 'moshe',
        isFinishOnboarding: true,
      );
    });
  }

  Future<List<CardOfGroup>> getCards() async {
    return await Future.delayed(const Duration(seconds: 2), () {
      return [CardOfGroup(groupName: 0), CardOfGroup(groupName: 2), CardOfGroup(groupName: 3), CardOfGroup(groupName: 4)];
    });
  }

  savesSwipes(){

  }

}
