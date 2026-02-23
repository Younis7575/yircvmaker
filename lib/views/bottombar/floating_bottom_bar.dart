import 'package:cvmaker/views/bottombar/bottom_screens.dart';
import 'package:cvmaker/views/craete/add_cv_screen.dart';
import 'package:cvmaker/views/downlaod/my_downloads_screen.dart';
// home_screen.dart is no longer needed here since downloads is the new starting page
import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';

class FloatingBottomExample extends StatefulWidget {
  @override
  State<FloatingBottomExample> createState() =>
      _FloatingBottomExampleState();
}

class _FloatingBottomExampleState extends State<FloatingBottomExample>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;
  int currentIndex = 0;

  final List<Widget> screens = [
    // the 'home' tab now displays the downloads screen
    MyDownloadsScreen(),
    SearchScreen(),
    AddCvScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 5, vsync: this);

    _tabController.addListener(() {
      setState(() {
        currentIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomBar(
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [

            /// TAB BAR
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              tabs: [
                Icon(Icons.home,
                    color: currentIndex == 0
                        ? Colors.blue
                        : Colors.grey),

                Icon(Icons.search,
                    color: currentIndex == 1
                        ? Colors.blue
                        : Colors.grey),

                SizedBox(width: 40), // Space for FAB

                Icon(Icons.favorite,
                    color: currentIndex == 3
                        ? Colors.blue
                        : Colors.grey),

                Icon(Icons.settings,
                    color: currentIndex == 4
                        ? Colors.blue
                        : Colors.grey),
              ],
            ),

            /// CENTER FAB
            Positioned(
              top: -25,
              child: FloatingActionButton(
                backgroundColor: Colors.blue,
                onPressed: () {
                  _tabController.animateTo(2);
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),

        fit: StackFit.expand,
        borderRadius: BorderRadius.circular(30),
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        showIcon: false,
        width: MediaQuery.of(context).size.width * 0.9,
        barColor: Colors.white,
        start: 2,
        end: 0,
        offset: 10,
        barAlignment: Alignment.bottomCenter,
        respectSafeArea: true,

        body: (context, controller) => TabBarView(
          controller: _tabController,
          physics: BouncingScrollPhysics(),
          children: screens,
        ),
      ),
    );
  }
}