import 'package:architecture/models/group.dart';
import 'package:flutter/material.dart';

class MyUser {
  MyUser({required this.name, this.isFinishOnboarding,this.album,this.description,this.myGroups,required this.uId});
  String uId;
  String name;
  List<Image>? album;
  String? description;
  bool? isFinishOnboarding;
  List<Group>? myGroups;


  //minimle example for reading and writing data from server/to server.
  Map toMap() => {"name": name, "uId": uId, "groups": myGroups};

  static fromMap(Map map){
    List<Group> groups = [];
    for(var group in map["groups"]){
      ///
    }
  }
}

class User {
  User({required this.name,this.album,this.description});
  String name;
  List<Image>? album;
  String? description;
}
