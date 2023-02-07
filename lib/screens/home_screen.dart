import 'package:blog_app/screens/user_screen.dart';
import 'package:flutter/material.dart';

import './discover_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pages = [
    const DiscoverScreen(),
    UserScreen(),
  ];
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: pages[currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() {
          currentIndex = value;
        }),
        selectedItemColor: Colors.white,
        backgroundColor: Colors.grey[900],
        currentIndex: currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );

    // body: CustomScrollView(
    //   physics: const BouncingScrollPhysics(),
    //   slivers: [
    //     mySliverAppBar(
    //       () async {
    //         await Future.delayed(
    //           const Duration(seconds: 1),
    //           () => print('Load new data!'),
    //         );
    //         // await Server.requestNewData();
    //       },
    //       context,
    //     ),
    //     // SliverList(
    //     //   delegate: SliverChildBuilderDelegate(
    //     //     (BuildContext context, int index) => Blogcard(
    //     //       blog: dummyData[index],
    //     //     ),
    //     //     childCount: dummyData.length,
    //     //   ),
    //     // )
    //     SliverToBoxAdapter(

    //     ),
    //   ],
    // ),
  }
}
