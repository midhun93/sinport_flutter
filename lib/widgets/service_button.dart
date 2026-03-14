import 'package:flutter/material.dart';

class ServiceButton extends StatefulWidget {

  final String title;
  final Color color;
  final IconData icon;
  final bool darkIcon;

  const ServiceButton({
    super.key,
    required this.title,
    required this.color,
    required this.icon,
    this.darkIcon = false,
  });

  @override
  State<ServiceButton> createState() => _ServiceButtonState();
}

class _ServiceButtonState extends State<ServiceButton> {

  double scale = 1;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTapDown: (_) => setState(() => scale = 0.95),
      onTapUp: (_) => setState(() => scale = 1),
      onTapCancel: () => setState(() => scale = 1),

      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 120),

        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),

          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(22),
          ),

          child: Row(
            children: [

              Icon(
                widget.icon,
                color: widget.darkIcon ? Colors.black : Colors.black,
              ),

              const SizedBox(width: 12),

              Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: widget.darkIcon ? Colors.black : Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}