import 'package:architecture/models/card.dart';
import 'package:architecture/models/user.dart';
import 'package:architecture/services/http.dart';
import 'package:flutter/cupertino.dart';

class UserModel extends ChangeNotifier {
  final HttpRequest _httpRequest = HttpRequest();
  
// model variebles = variebels which used by the model to determine varieble states
  late List<CardOfGroup> _cards;

// ui variebles
  late MyUser _user;
  late CardOfGroup _card;
  // late String _userName;

// state variebles
  late CardsState _cardsState;
  
  

  UserModel() {
    //initial ui variebles
    _user = MyUser(name: 'moshe');
    //initial ui components states
    _cardsState = CardsState.cardsLoading;
    //initial model varieble
    _cards = [];
    _card = CardOfGroup(groupName: 1);
    //initial functions
    getCard();
  }


  get card => _card;
  get userName => _user.name;
  get cardsState => _cardsState;


//                                   SwipePage

  getCard() async {
    if (_cards.isEmpty) {
      _cardsState = CardsState.cardsLoading;
      notifyListeners();
      _cards = await _httpRequest.getCards();
      _card = _cards.last;
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
        _httpRequest.savesSwipes();
        _card = _cards.last;
        notifyListeners();
      }
    }
  }

  changeUserName(String newUserName){
   _user.name= newUserName;
   notifyListeners();
  }


//enum

}

enum CardsState { noAvilableCards, cardsReady, cardsLoading }


