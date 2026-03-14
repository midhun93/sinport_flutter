import 'package:flutter/material.dart';

class ServiceButton extends StatefulWidget {
  final String? title;
  final Color color;
  final Widget icon;
  final bool isWide;

  const ServiceButton({
    super.key,
    this.title,
    required this.color,
    required this.icon,
    this.isWide = false,
  });

  @override
  State<ServiceButton> createState() => _ServiceButtonState();
}

class _ServiceButtonState extends State<ServiceButton> {
  double scale = 1;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.isWide ? 2 : 1,
      child: GestureDetector(
        onTapDown: (_) => setState(() => scale = 0.92),
        onTapUp: (_) => setState(() => scale = 1),
        onTapCancel: () => setState(() => scale = 1),
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 100),
          child: Container(
            height: 85,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(28),
            ),
            child: widget.isWide
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.icon,
                      const SizedBox(width: 12),
                      Text(
                        widget.title ?? "",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      )
                    ],
                  )
                : Center(child: widget.icon),
          ),
        ),
      ),
    );
  }
}
