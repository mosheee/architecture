import 'package:architecture/viewModel/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:architecture/models/card.dart';
import 'package:tuple/tuple.dart';

class SwipePage extends StatelessWidget {
  const SwipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const CustomAppBar(),
        ),
        body: const Center(child: Swipe()),
      ),
    );
  }
}

class Swipe extends StatelessWidget {
  const Swipe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<UserModel>().getCard();
      },
      child: Selector<UserModel, CardsState>(
        selector: (_, userModel) => userModel.cardsState,
        builder: (context, cardsState, child) {
          switch (cardsState) {
            case CardsState.cardsLoading:
              {
                return const Center(child: CircularProgressIndicator());
              }
            case CardsState.cardsReady:
              {
                return const CustomCard();
              }
            case CardsState.noAvilableCards:
              {
                return const Text('no avilable catds');
              }
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<UserModel, CardsState>(
        selector: (_, userModel) => userModel.cardsState,
        builder: (context, cardsState, child) {
          switch (cardsState) {
            case CardsState.cardsReady:
              {
                return const CustomCard();
              }
            default:
              return const SizedBox();
          }
        },
      );
  }
}


class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // run every time userModel refresh card varieble
    return Selector<UserModel, CardOfGroup>(
        selector: (_, userModel) => userModel.card,
        builder: (context, card, child) {
          return Text('${card.groupName}');
        });
  }
}
