import 'package:architecture/view/chat_page.dart';
import 'package:architecture/view/privateProfilePage.dart';
import 'package:architecture/view/swipe_page.dart';
import 'package:architecture/view/switch_group_page.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Widget> _children;

  @override
  void initState() {
    _children = [
      const SwipePage(),
      const PrivateProfilePage(),
      const ChatPage(),
      const SwitchGroupPage()
    ];
    _tabController = TabController(length: 4, vsync: this);
    _tabController.index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:TabBarView(
            children: _children,
            controller: _tabController,
          ),
      bottomNavigationBar: TabBar(
          unselectedLabelColor: Colors.black.withOpacity(0.3),
          labelColor: Colors.blueGrey,
          indicatorColor: Colors.transparent,
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.swipe),
            ),
            Tab(icon: Icon(Icons.portrait)),
            Tab(
              icon: Icon(Icons.message),
            ),
            Tab(
              icon: Icon(Icons.people),
            ),
          ]),
    );
  }
}
