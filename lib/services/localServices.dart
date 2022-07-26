import 'package:architecture/models/user.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

// minimale example of usege of local disk
class LocalService {
  static clearAll() async => await Hive.deleteFromDisk();

  static initialize() async {
    await Hive.initFlutter();
  }

  saveUserInfo(MyUser user) async {
    Box userBox = await Hive.openBox(user.uId);
    await userBox.putAll(user.toMap());
    await userBox.close();
  }

  Future<MyUser?> getUser(String uid) async {
    Box userBox = await Hive.openBox(uid);
    if (userBox.isEmpty) return null;
    MyUser user = MyUser.fromMap(userBox.toMap());
    userBox.close();
    return user;
  }
}