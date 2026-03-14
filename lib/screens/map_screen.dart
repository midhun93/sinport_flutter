import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool isSearching = false;
  bool showDetail = false;
  bool isNavigating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff071B2E),
      body: Stack(
        children: [
          // Background Map Image
          Positioned.fill(
            child: Image.network(
              "https://i.ibb.co/L9hVf0T/map-bg.png", // Placeholder for the 3D map style
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xff0F2238),
                child: const Center(
                  child: Icon(Icons.map, color: Colors.white24, size: 100),
                ),
              ),
            ),
          ),

          // Custom 3D-like elements overlay (Simulated)
          if (!isSearching) _buildMapOverlay(),

          // Top Navigation Bar (Search & Categories)
          if (!isSearching && !isNavigating) _buildTopBar(),

          // Navigation Banner
          if (isNavigating) _buildNavigationBanner(),

          // Zoom & Floor Controls
          if (!isSearching) _buildSideControls(),

          // Bottom Sheet / Info Card
          if (showDetail && !isNavigating) _buildDetailCard(),
          
          if (isNavigating) _buildNavigationInfoCard(),

          // Search Overlay
          if (isSearching) _buildSearchOverlay(),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildRoundIconButton(Icons.search, const Color(0xffF6C445), onTap: () {
              setState(() => isSearching = true);
            }),
            const SizedBox(width: 12),
            _buildCategoryButton(Icons.shopping_bag, "Shopping"),
            const SizedBox(width: 12),
            _buildCategoryButton(Icons.logout, "Gates"),
            const SizedBox(width: 12),
            _buildCategoryButton(Icons.credit_card, "ATM"),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundIconButton(IconData icon, Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, color: Colors.black, size: 24),
      ),
    );
  }

  Widget _buildCategoryButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSideControls() {
    return Stack(
      children: [
        // Floor Controls
        Positioned(
          left: 20,
          top: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            children: [
              _buildFloorButton("2", false),
              const SizedBox(height: 8),
              _buildFloorButton("1", true),
              const SizedBox(height: 8),
              _buildFloorButton("-1", false),
            ],
          ),
        ),
        // Zoom Controls
        Positioned(
          right: 20,
          top: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            children: [
              _buildRoundIconButton(Icons.add, Colors.white),
              const SizedBox(height: 8),
              _buildRoundIconButton(Icons.remove, Colors.white),
            ],
          ),
        ),
        // Location Button
        Positioned(
          right: 20,
          bottom: showDetail || isNavigating ? 220 : 120,
          child: _buildRoundIconButton(Icons.my_location, Colors.white, onTap: () {
            setState(() => showDetail = !showDetail);
          }),
        ),
      ],
    );
  }

  Widget _buildFloorButton(String label, bool active) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.white.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.black : Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildMapOverlay() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Current location indicator
          Container(
            width: 40,
            height: 25,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffF6C445), width: 3),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          // View cone
          CustomPaint(
            painter: ViewConePainter(),
            size: const Size(100, 100),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard() {
    return Positioned(
      bottom: 110,
      left: 20,
      right: 20,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Gate 1C",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () => setState(() => showDetail = false),
                    )
                  ],
                ),
                const Text("Airport infrastructure", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _buildSquareIcon(Icons.share),
                    const SizedBox(width: 12),
                    _buildSquareIcon(Icons.bookmark_border),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                showDetail = false;
                isNavigating = true;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              decoration: const BoxDecoration(
                color: Color(0xffF6C445),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Build a route", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Icon(Icons.north_east),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSquareIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 20),
    );
  }

  Widget _buildSearchOverlay() {
    return Container(
      color: const Color(0xff071B2E),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Color(0xffF6C445)),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      decoration: InputDecoration(
                        hintText: "Where do you want to go?",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      autofocus: true,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.white),
                    onPressed: () => setState(() => isSearching = false),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("You have already looked", style: TextStyle(color: Colors.grey, fontSize: 16)),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView(
                        children: [
                          _buildSearchItem("Gate 1C", "700 m away from you"),
                          _buildSearchItem("Zara store", "900 m away from you"),
                          _buildSearchItem("Samsung store", "800 m away from you"),
                          _buildSearchItem("McDonald's", "1,2 km away from you"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchItem(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const Icon(Icons.north_east, color: Color(0xffF6C445)),
        ],
      ),
    );
  }

  Widget _buildNavigationBanner() {
    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xffF6C445),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          children: [
            Icon(Icons.turn_left, size: 32),
            SizedBox(width: 16),
            Text(
              "100 m turn left",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationInfoCard() {
    return Positioned(
      bottom: 110,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavStat("10:00", "Arrival"),
                Container(width: 1, height: 40, color: Colors.grey[200]),
                _buildNavStat("1 km", "Distance"),
                Container(width: 1, height: 40, color: Colors.grey[200]),
                _buildNavStat("5 min", "On the way"),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Cancel", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() => isNavigating = false),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNavStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

class ViewConePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Colors.white.withOpacity(0.3),
          Colors.white.withOpacity(0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    path.moveTo(size.width / 2, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
