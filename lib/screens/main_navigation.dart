import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'dog_finder_screen.dart';
import 'doctor_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    DogFinderScreen(),
    DoctorScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTabChanged: _onTabTapped,
      ),
    );
  }
}
