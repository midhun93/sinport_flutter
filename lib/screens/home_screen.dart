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
    const HomeContent(), // Home
    const MapScreen(),   // Map
    const Center(child: Text("Calendar", style: TextStyle(color: Colors.white))),
    const Center(child: Text("Grid", style: TextStyle(color: Colors.white))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff071B2E),
      body: Stack(
        children: [
          // Animated Page Switcher
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (Widget child, Animation<double> animation) {
                final offsetAnimation = Tween<Offset>(
                  begin: const Offset(0.05, 0),
                  end: Offset.zero,
                ).animate(animation);
                
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  ),
                );
              },
              child: SafeArea(
                key: ValueKey<int>(currentIndex),
                child: pages[currentIndex],
              ),
            ),
          ),
          
          // Bottom Navigation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNav(
              currentIndex: currentIndex,
              onTap: (index) {
                if (index < pages.length) {
                  setState(() {
                    currentIndex = index;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
