import 'package:architecture/models/group.dart';
import 'package:architecture/services/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:architecture/models/card.dart';


class CardsHandler extends ChangeNotifier {

  final Repository _repository = Repository();

  late List<CardOfGroup> _cards;
  late CardsState _cardsState;
  late Group currentGroup;
  late String _uId;

  get card => _cards.last;
  get cardsState => _cardsState;

  initalDataForNewStackOfCards({required Group group,required uId}){
    _cardsState = CardsState.cardsLoading;
    _cards = [];
    _uId = uId;
    currentGroup = group;
    getCard();
  }

  
  getCard() async {
    if (_cards.isEmpty) {
      _cardsState = CardsState.cardsLoading;
      notifyListeners();
      _cards = await _repository.getCards(userId: _uId,groupId: currentGroup.groupId);
      _cardsState = CardsState.cardsReady;
      notifyListeners();
    } else {
      if (_cards.length == 1) {
        _cards.removeLast();
        _cardsState = CardsState.cardsLoading;
        notifyListeners();
        getCard();
      } else {
        _cards.removeLast();
        _repository.savesSwipes();
        notifyListeners();
      }
    }
  }

  changeGroupToSwipeFor({required Group group}){
    currentGroup = group;
    _cardsState = CardsState.cardsLoading;
    _cards = [];
    getCard();
  }





}



enum CardsState { noAvilableCards, cardsReady, cardsLoading }
