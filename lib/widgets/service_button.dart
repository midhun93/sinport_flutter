import 'package:flutter/material.dart';
import 'bouncy_button.dart';

class ServiceButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Expanded(
      flex: isWide ? 2 : 1,
      child: BouncyButton(
        child: Container(
          height: 85,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(28),
          ),
          child: isWide
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon,
                    const SizedBox(width: 12),
                    Text(
                      title ?? "",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    )
                  ],
                )
              : Center(child: icon),
        ),
      ),
    );
  }
}
