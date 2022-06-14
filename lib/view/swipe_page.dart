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
          title: const MyAppBar(),
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
        context.read<ViewModel>().getCard();
      },
      child: Selector<ViewModel, CardsState>(
        selector: (_, userModel) => userModel.cardsState,
        builder: (context, cardsState, child) {
          print('SwipeState changed');
          switch (cardsState) {
            case CardsState.cardsLoading:
              {
                return const Center(child: CircularProgressIndicator());
              }
            case CardsState.cardsReady:
              {
                return CustomCard();
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

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ViewModel, CardsState>(
      selector: (_, userModel) => userModel.cardsState,
      builder: (context, cardsState, child) {
        switch (cardsState) {
          case CardsState.cardsReady:
            {
              return Builder(
                builder: (context) {
                  final CardOfGroup card = context.watch<ViewModel>().card;
                  return Text('${card.groupName}');
                }
              );
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
    final CardOfGroup card = context.watch<ViewModel>().card;
    return Text('${card.groupName}');
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CardOfGroup card = context.watch<ViewModel>().card;
    return Text('${card.groupName}');
  }
}
