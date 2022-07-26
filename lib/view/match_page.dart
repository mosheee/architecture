import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewModel/chats_list.dart';
import '../viewModel/match_list.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30, bottom: 10),
            child: Text(
              'My Groups',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 20,
                    child: Text('$index'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Body()
        ],
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Toggle _toggle = Toggle.chats;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  _toggle = Toggle.chats;
                  setState(() {});
                },
                child: const Text('chats')),
            const SizedBox(
              width: 30,
            ),
            TextButton(
                onPressed: () {
                  _toggle = Toggle.matches;
                  setState(() {});
                },
                child: const Text('matches'))
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        _toggle == Toggle.chats ? const Chats() : const Matches()
      ],
    );
  }
}

class Matches extends StatelessWidget {
  const Matches({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<MatchList, MatchListState>(
        selector: (_, model) => model.matchListState,
        builder: (context, state, child) {
          switch (state) {
            case MatchListState.isLoading:
              return const CircularProgressIndicator();
            case MatchListState.isEmpty:
              return const Text('no matches');
            case MatchListState.dataReady:
            List<String> matches = context.read<MatchList>().matchList;
              return Container(
                height: 200,
                child: ListView.builder(
                    itemCount: matches.length ,
                    itemBuilder: ((context, index) => Card(
                          child: ListTile(leading: Text(matches[index])),
                        ))),
              );
            default:
              return const SizedBox();
          }
        });
  }
}

enum Toggle { chats, matches }


class Chats extends StatelessWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ChatsList, ChatsListState>(
        selector: (_, model) => model.chatsListState,
        builder: (context, state, child) {
          switch (state) {
            case ChatsListState.isLoading:
              return const CircularProgressIndicator();
            case ChatsListState.isEmpty:
              return const Text('no chats');
            case ChatsListState.dataReady:
            List<String> chats = context.read<ChatsList>().chatsList;
              return Container(
                height: 200,
                child: ListView.builder(
                    itemCount: chats.length ,
                    itemBuilder: ((context, index) => Card(
                          child: ListTile(leading: Text(chats[index])),
                        ))),
              );
            default:
              return const SizedBox();
          }
        });
  }
}