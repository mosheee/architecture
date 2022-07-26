import 'package:architecture/services/http.dart';
import 'package:flutter/cupertino.dart';

class ChatsList extends ChangeNotifier{

final Repository _repository = Repository();

late ChatsListState _chatsListState;
late List<String> _chatsList;
get chatsListState => _chatsListState;
get chatsList => _chatsList;

initializeData(String uId){
  _chatsListState = ChatsListState.isLoading;
  _chatsList = [];
  listenToMatches(uId);
  
}


listenToMatches(String userId) async{
 final List<String>? list = await _repository.getUserChats(userId: userId);
 if(list == null){
   _chatsListState = ChatsListState.error;
 }else if(list.isEmpty){
   _chatsListState = ChatsListState.isEmpty;
 }else{
   _chatsList = list;
   _chatsListState = ChatsListState.dataReady;
   print('im here');
 }
 notifyListeners();
}
}





enum ChatsListState {isLoading, isEmpty, dataReady,error}