import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wheatwise/features/article/screens/article_screen.dart';
import 'package:wheatwise/features/home/bloc/diagnosis_statistics_bloc.dart';
import 'package:wheatwise/features/home/bloc/diagnosis_statistics_event.dart';
import 'package:wheatwise/features/home/screens/home_screen.dart';
import 'package:wheatwise/features/records/recent_records/screens/record_screen.dart';
import 'package:wheatwise/features/setting/screens/setting_screen.dart';
import 'package:wheatwise/features/test_screen/test_screen.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PageNavigator extends StatefulWidget {
  const PageNavigator({super.key});

  @override
  State<PageNavigator> createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ArticleScreen(),
    const RecordScreen(),
    const SettingScreen(),
    const TestScreen(),
  ];

  void _onTabTapped(int index) {  
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    BlocProvider.of<DiagnosisStatisticsBloc>(context)
        .add(const LoadDiagnosisStatisticsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.grey),
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
              label: 'Articles',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.folder_open),
              label: 'Records',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.setting),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.setting),
              label: 'Test',
            ),
          ],
        ),
      ),
    );
  }
}
