import 'package:flutter/material.dart';
import '../widgets/service_button.dart';
import '../widgets/departure_card.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const Text(
            "Good afternoon!",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 6),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Airport map",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Icon(Icons.north_east, color: Colors.amber)
            ],
          ),

          const SizedBox(height: 30),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 2.2,

            children: const [

              ServiceButton(
                title: "Transfer",
                color: Color(0xffF6C445),
                icon: Icons.sync_alt,
              ),

              ServiceButton(
                title: "Hotel",
                color: Color(0xffECECEC),
                icon: Icons.hotel,
                darkIcon: true,
              ),

              ServiceButton(
                title: "Baggage",
                color: Color(0xffECECEC),
                icon: Icons.luggage,
                darkIcon: true,
              ),

              ServiceButton(
                title: "Tickets",
                color: Color(0xffFF5A5A),
                icon: Icons.confirmation_num,
              ),

              ServiceButton(
                title: "Car Rent",
                color: Color(0xff7ED387),
                icon: Icons.directions_car,
              ),

              ServiceButton(
                title: "Chat",
                color: Color(0xffECECEC),
                icon: Icons.chat,
                darkIcon: true,
              ),
            ],
          ),

          const SizedBox(height: 35),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [

              Text(
                "Upcoming departures",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              Row(
                children: [
                  Text(
                    "View all",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.north_east, color: Colors.amber, size: 18)
                ],
              )
            ],
          ),

          const SizedBox(height: 16),

          const DepartureCard(
            from: "Singapore",
            to: "San Francisco",
            time: "27 Aug 2022 13:22",
          ),

          const SizedBox(height: 14),

          const DepartureCard(
            from: "Singapore",
            to: "New York",
            time: "27 Aug 2022 14:11",
          ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }
}