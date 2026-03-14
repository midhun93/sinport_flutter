import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import 'home_content.dart';
import 'map_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 0;

  final pages = [
    const HomeContent(),   // Home
    const MapScreen(),     // Map
    const SizedBox(),      // Calendar (center button)
    const SizedBox(),      // Bookmark
    const SizedBox(),      // Grid
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xff071B2E),

      body: SafeArea(
        child: pages[currentIndex],
      ),

      bottomNavigationBar: BottomNav(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}