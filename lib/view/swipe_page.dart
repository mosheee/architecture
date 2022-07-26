import 'package:architecture/models/group.dart';
import 'package:architecture/viewModel/cardsHandler.dart';
import 'package:architecture/viewModel/userViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:architecture/models/card.dart';
import 'package:random_avatar/random_avatar.dart';

import '../models/user.dart';

class SwipePage extends StatelessWidget {
  const SwipePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Group currentGroup =
        context.watch<CardsHandler>().currentGroup;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  const SizedBox(
                    width: 160,
                  ),
                  Text(
                    currentGroup.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.blue),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeGroupPage()));
                    },
                    child: const Text('change group',
                        style: TextStyle(color: Colors.white)),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Selector<CardsHandler, CardsState>(
              selector: (_, model) => model.cardsState,
              builder: (_, state, child) {
                switch (state) {
                  case CardsState.cardsLoading:
                    return const Center(child: CircularProgressIndicator());
                  case CardsState.noAvilableCards:
                    return const Center(
                      child: Text('no availble cards'),
                    );
                  case CardsState.cardsReady:
                    return Column(
                      children:  [
                        const Democracy(),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Selector<CardsHandler,CardOfGroup>(
                            selector: (_,model) => model.card,
                            builder: (context,card,child) {
                              return Cards(group: card,);
                            }
                          ),
                        )
                      ],
                    );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}



class Cards extends StatelessWidget {
  const Cards({Key? key, required this.group}) : super(key: key);
  final CardOfGroup group;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<CardsHandler>().getCard();
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
                color: Colors.primaries[
                    (group.groupName.length) % Colors.primaries.length],
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Center(child: randomAvatar(group.groupName)),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      group.groupName,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Text('average age : ${group.averageAge}'),
                    Text('average age : ${group.groupMembers!.length}'),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class Democracy extends StatelessWidget {
  const Democracy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          MembersHowLoveTheGroup(),
          SizedBox(
            width: 50,
          ),
          MembersHowDidntLoveTheGroup()
        ],
      ),
    );
  }
}



class MembersHowLoveTheGroup extends StatelessWidget {
  const MembersHowLoveTheGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.blue.withOpacity(0.5),
      child: const Icon(
        Icons.man,
        size: 25,
        color: Colors.green,
      ),
      radius: 25,
    );
  }
}

class MembersHowDidntLoveTheGroup extends StatelessWidget {
  const MembersHowDidntLoveTheGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.blue.withOpacity(0.5),
      child: const Icon(
        Icons.man,
        size: 25,
        color: Colors.red,
      ),
      radius: 25,
    );
  }
}


class ChangeGroupPage extends StatelessWidget {
  const ChangeGroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyUser user = context.read<UserViewModel>().user;
    final CardsHandler cardsHandler = context.read<CardsHandler>();
    return Scaffold(body: Column(children: [
      IconButton(onPressed: (){
          Navigator.pop(context);
      }, icon: const Icon(Icons.exit_to_app)),
      const SizedBox(height: 40,),
      SizedBox(
        height: 400,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: GridView.builder(
            gridDelegate:const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
            itemCount: user.myGroups!.length,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                cardsHandler.changeGroupToSwipeFor(group: user.myGroups![index]);
                Navigator.pop(context);
                },
                child: Container(
                      alignment: Alignment.center,
                      child: Text(user.myGroups![index].name),
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(15)),
                    ),
              );
            },
           ),
        ),
      )
    ],),);
  }
}