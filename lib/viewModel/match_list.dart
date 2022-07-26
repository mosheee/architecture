

import 'package:architecture/services/http.dart';
import 'package:flutter/cupertino.dart';

class MatchList extends ChangeNotifier{

final Repository _repository = Repository();

late MatchListState _matchListState;
late List<String> _matchList;
get matchListState => _matchListState;
get matchList => _matchList;

initializeData(String uId){
  _matchListState = MatchListState.isLoading;
  _matchList = [];
  listenToMatches(uId);
  
}


listenToMatches(String userId) async{
 final List<String>? list = await _repository.getUserMatches(userId: userId);
 if(list == null){
   _matchListState = MatchListState.error;
 }else if(list.isEmpty){
   _matchListState = MatchListState.isEmpty;
 }else{
   _matchList = list;
   _matchListState = MatchListState.dataReady;
   print('im here');
 }
 notifyListeners();
}
}





enum MatchListState {isLoading, isEmpty, dataReady,error}