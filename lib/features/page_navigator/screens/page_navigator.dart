import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wheatwise/features/article/screens/article_screen.dart';
import 'package:wheatwise/features/home/screens/home_screen.dart';
import 'package:wheatwise/features/records/recent_records/screens/record_screen.dart';
import 'package:wheatwise/features/setting/screens/setting_screen.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PageNavigator extends StatefulWidget {
  const PageNavigator({super.key});

  @override
  State<PageNavigator> createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator> {
  int _currentIndex = 1;

  final List<Widget> _screens = [
    HomeScreen(),
    const ArticlesScreen(),
    const RecordScreen(),
    const SettingScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
                width: 1.0, color: Colors.grey), // Add a border on top
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          currentIndex: _currentIndex,
          selectedItemColor: const Color.fromRGBO(248, 147, 29, 1),
          unselectedItemColor: const Color.fromARGB(255, 128, 128, 128),
          onTap: _onTabTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.book),

              // icon: Icon(
              //   FontAwesomeIcons.bookOpen,
              // ),

              // icon: Icon(Iconsax.book1),
              label: 'Articles',
            ),
            BottomNavigationBarItem(
              // icon: FaIcon(
              //   FontAwesomeIcons.upload,
              //   size: 24, // Adjust the size as needed
              // ),
              icon: Icon(Iconsax.book),
              label: 'Records',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.setting),
              label: 'Settings',
            ),
          ],
        ),
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   elevation: 0,
      //   currentIndex: _currentIndex,
      //   selectedItemColor: Colors.black,
      //   onTap: _onTabTapped,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.article),
      //       label: 'Articles',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.library_books),
      //       label: 'Records',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'Settings',
      //     ),
      //   ],
      // ),
    );
  }
}
