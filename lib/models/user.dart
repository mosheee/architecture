import 'package:architecture/models/group.dart';
import 'package:flutter/material.dart';

class MyUser {
  MyUser({required this.name, this.isFinishOnboarding,this.album,this.description});
  String name;
  List<Image>? album;
  String? description;
  bool? isFinishOnboarding;
  List<Group>? myGroups;
}

class User {
  User({required this.name,this.album,this.description});
  String name;
  List<Image>? album;
  String? description;
}
