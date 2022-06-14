import 'package:architecture/models/card.dart';
import 'package:architecture/models/user.dart';
import 'package:architecture/services/http.dart';
import 'package:flutter/cupertino.dart';

class ViewModel extends ChangeNotifier {
  final Repository _repository = Repository();
  GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "root navigation key");

// model variebles = variebels which used by the model to determine varieble states
  late List<CardOfGroup> _cards;

// state variebles
  late CardsState _cardsState;

// ui variebles
  late MyUser? _user;

  get card => _cards.last;
  get userName => _user!.name;
  get cardsState => _cardsState;

  ViewModel() {
    print('in');
    //initial ui components states
    _cardsState = CardsState.cardsLoading;
    //initial model varieble
    _cards = [];
    //initialize resources 
    getUser();
    getCard();
  }

  getUser() async {
    _user = await _repository.getUser();
    _user != null ? navigateToHomePage() : navigateToErrorPage();
  }

//                                   SwipePage

  getCard() async {
    if (_cards.isEmpty) {
      _cardsState = CardsState.cardsLoading;
      notifyListeners();
      _cards = await _repository.getCards();
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

  changeUserName(String newUserName) {
    _user!.name = newUserName;
    notifyListeners();
     rootNavigatorKey.currentState!.pop();
  }
  navigateToHomePage() => rootNavigatorKey.currentState!.pushReplacementNamed('/home');
  navigateToErrorPage() => rootNavigatorKey.currentState!.pushNamed('/error');
  navigateToEditPage() => rootNavigatorKey.currentState!.pushNamed('/editing');
}

//enum

enum CardsState { noAvilableCards, cardsReady, cardsLoading }
