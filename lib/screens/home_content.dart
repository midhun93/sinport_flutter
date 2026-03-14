import 'package:flutter/material.dart';
import '../widgets/service_button.dart';
import '../widgets/departure_card.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAnimatedItem(
            delay: 0,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  "Good afternoon!",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Airport map",
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Icon(Icons.north_east, color: Color(0xffF6C445), size: 38)
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          _buildAnimatedItem(
            delay: 100,
            child: Row(
              children: [
                const ServiceButton(
                  title: "Transfer",
                  color: Color(0xffF6C445),
                  isWide: true,
                  icon: Icon(Icons.taxi_alert_rounded, size: 28),
                ),
                const SizedBox(width: 16),
                ServiceButton(
                  color: Colors.white,
                  icon: Image.network(
                    "https://cdn-icons-png.flaticon.com/512/3009/3009489.png",
                    width: 32,
                    height: 32,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.hotel, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          _buildAnimatedItem(
            delay: 200,
            child: Row(
              children: [
                ServiceButton(
                  color: Colors.white,
                  icon: Image.network(
                    "https://cdn-icons-png.flaticon.com/512/2961/2961571.png",
                    width: 32,
                    height: 32,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.luggage, color: Colors.black),
                  ),
                ),
                const SizedBox(width: 16),
                const ServiceButton(
                  title: "Tickets",
                  color: Color(0xffFF5A5A),
                  isWide: true,
                  icon: Icon(Icons.confirmation_num, size: 28),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          _buildAnimatedItem(
            delay: 300,
            child: Row(
              children: [
                const ServiceButton(
                  title: "Car Rent",
                  color: Color(0xff8DEE9D),
                  isWide: true,
                  icon: Icon(Icons.directions_car_filled, size: 28),
                ),
                const SizedBox(width: 16),
                ServiceButton(
                  color: Colors.white,
                  icon: Image.network(
                    "https://cdn-icons-png.flaticon.com/512/2462/2462719.png",
                    width: 32,
                    height: 32,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.chat_bubble, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 48),

          _buildAnimatedItem(
            delay: 400,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Upcoming departures",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "View all",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.north_east, color: Color(0xffF6C445), size: 20)
                  ],
                )
              ],
            ),
          ),

          const SizedBox(height: 24),

          _buildAnimatedItem(
            delay: 500,
            child: const DepartureCard(
              from: "Singapoure",
              to: "San Francisco",
              time: "27 Aug 2022 13:22",
              gate: "Gate 1C",
            ),
          ),

          const SizedBox(height: 24),
          
          _buildAnimatedItem(
            delay: 550,
            child: const Divider(color: Colors.white10, height: 1),
          ),
          
          const SizedBox(height: 24),

          _buildAnimatedItem(
            delay: 600,
            child: const DepartureCard(
              from: "Singapoure",
              to: "New York",
              time: "27 Aug 2022 14:11",
              gate: "Gate 2B",
            ),
          ),

          const SizedBox(height: 120),
        ],
      ),
    );
  }

  Widget _buildAnimatedItem({required int delay, required Widget child}) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + delay),
      curve: Curves.easeOutQuart,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
