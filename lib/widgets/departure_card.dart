import 'package:flutter/material.dart';

class DepartureCard extends StatelessWidget {
  final String from;
  final String to;
  final String time;
  final String gate;

  const DepartureCard({
    super.key,
    required this.from,
    required this.to,
    required this.time,
    required this.gate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$from - $to",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              time,
              style: const TextStyle(
                color: Color(0xff757575),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              gate,
              style: const TextStyle(
                color: Color(0xff757575),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
