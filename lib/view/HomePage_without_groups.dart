import 'package:architecture/view/match_page.dart';
import 'package:architecture/view/private_profile_page.dart';
import 'package:architecture/view/swipe_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:architecture/viewModel/userViewModel.dart';

class HomePageWithoutGroups extends StatefulWidget {
  const HomePageWithoutGroups({Key? key}) : super(key: key);

  @override
  State<HomePageWithoutGroups> createState() => _HomePageWithoutGroupsState();
}

class _HomePageWithoutGroupsState extends State<HomePageWithoutGroups>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Widget> _children;

  @override
  void initState() {
    _children = [
      const SwipePageWithoutGroups(),
      const PrivateProfilePage(),
      const ChatPageWithoutGroups(),
    ];
    _tabController = TabController(length: 4, vsync: this);
    _tabController.index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: TabBarView(
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

class SwipePageWithoutGroups extends StatelessWidget {
  const SwipePageWithoutGroups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('create or join to group');
  }
}

class ChatPageWithoutGroups extends StatelessWidget {
  const ChatPageWithoutGroups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('create or join to group');
  }
}
