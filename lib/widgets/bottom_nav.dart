import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(40, 0, 40, 40),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            blurRadius: 30,
            color: Colors.black.withOpacity(.2),
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildItem(Icons.home_filled, 0),
          _buildItem(Icons.map_outlined, 1),
          _buildItem(Icons.calendar_today_outlined, 2),
          _buildItem(Icons.grid_view_rounded, 3),
        ],
      ),
    );
  }

  Widget _buildItem(IconData icon, int index) {
    bool selected = index == currentIndex;

    return _AnimatedNavItem(
      icon: icon,
      selected: selected,
      onTap: () => onTap(index),
    );
  }
}

class _AnimatedNavItem extends StatefulWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _AnimatedNavItem({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  State<_AnimatedNavItem> createState() => _AnimatedNavItemState();
}

class _AnimatedNavItemState extends State<_AnimatedNavItem> {
  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => scale = 0.8),
      onTapUp: (_) => setState(() => scale = 1.0),
      onTapCancel: () => setState(() => scale = 1.0),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: widget.selected ? const Color(0xffF6C445) : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            widget.icon,
            color: Colors.black,
            size: 28,
          ),
        ),
      ),
    );
  }
}
