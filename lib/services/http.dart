import 'package:architecture/models/card.dart';
import 'package:architecture/models/group.dart';
import 'package:architecture/models/user.dart';
import 'package:architecture/services/localServices.dart';

class Repository {
  // final LocalService _localService = LocalService();
  Future<MyUser> getUser() async {
    return await Future.delayed(const Duration(seconds: 2), () {
      return MyUser(uId:'',name: 'moshe', isFinishOnboarding: true, myGroups: [
        Group(
            groupId: '1',
            members: [User(name: 'r'), User(name: 'w')],
            name: 'the brothers',
            averageAge: 20),
        Group(
            groupId: '2',
            members: [User(name: 'f'), User(name: 'g')],
            name: 'the Homies',
            averageAge: 30)
      ]);
    });
  }

// get the cards of specific user in specific group
  Future<List<CardOfGroup>> getCards({required String groupId,required String userId}) async {
    return await Future.delayed(const Duration(seconds: 2), () {
      return [
        CardOfGroup(groupName: 'the boys',averageAge: 20,groupMembers: ['bbf','easdf','q','dsdfad']),
        CardOfGroup(groupName: 'the girls',averageAge: 23, groupMembers: ['f','e','q','dd']),
        CardOfGroup(groupName: 'the nosotros',averageAge: 44,groupMembers: ['s','d','v']),
        CardOfGroup(groupName: 'fum',averageAge: 22,groupMembers: ['t','r'])
      ];
    });
  }
   Future<List<String>> getUserMatches({required String userId}) async{
     // this function need to stream, for now it 
    return await Future.delayed(const Duration(seconds: 5),(){
     return ['w','e','s','q'];
    });
   }
      Future<List<String>> getUserChats({required String userId}) async{
     // this function need to stream, for now it 
    return await Future.delayed(const Duration(seconds: 10),(){
     return ['eeee','sss','bbbb','vvv'];
    });
   }
  savesSwipes() {}
}
