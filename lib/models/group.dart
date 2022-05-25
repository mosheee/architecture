
import 'package:flutter/material.dart';
import 'package:architecture/models/user.dart';

class Group {
  Group({required this.members, this.description, this.album,required this.name});
  List<User> members;
  String? description;
  String name;
  List<Image>? album;
}