import 'package:flutter/material.dart';

class DepartureCard extends StatelessWidget {

  final String from;
  final String to;
  final String time;

  const DepartureCard({
    super.key,
    required this.from,
    required this.to,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: const Color(0xff0F2238),
        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(
                  "$from - $to",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  "27 Aug 2022 13:22",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          const Text(
            "Gate 1C",
            style: TextStyle(
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}