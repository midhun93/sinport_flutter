import 'package:flutter/material.dart';

class MapLocation {
  final String title;
  final String distance;
  final String category;

  MapLocation({required this.title, required this.distance, required this.category});
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool isSearching = false;
  bool showDetail = false;
  bool isNavigating = false;
  String searchQuery = "";
  MapLocation? selectedLocation;

  final List<MapLocation> locations = [
    MapLocation(title: "Gate 1C", distance: "700 m away from you", category: "Airport infrastructure"),
    MapLocation(title: "Zara store", distance: "900 m away from you", category: "Shopping"),
    MapLocation(title: "Samsung store", distance: "800 m away from you", category: "Shopping"),
    MapLocation(title: "McDonald's", distance: "1,2 km away from you", category: "Food & Drinks"),
    MapLocation(title: "Gate 10C", distance: "100 m away from you", category: "Airport infrastructure"),
    MapLocation(title: "Balenciaga store", distance: "1 km away from you", category: "Shopping"),
    MapLocation(title: "Chanel Store", distance: "500 m away from you", category: "Shopping"),
  ];

  List<MapLocation> get filteredLocations {
    if (searchQuery.isEmpty) return locations;
    return locations
        .where((loc) => loc.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff071B2E),
      body: Stack(
        children: [
          // Background Map Image (Simulated 3D view)
          Positioned.fill(
            child: Container(
              color: const Color(0xff0F2238),
              child: Opacity(
                opacity: 0.5,
                child: Image.network(
                  "https://i.ibb.co/L9hVf0T/map-bg.png",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(Icons.map, color: Colors.white10, size: 200),
                  ),
                ),
              ),
            ),
          ),

          // Custom 3D-like elements overlay
          if (!isSearching) _buildMapOverlay(),

          // Top Navigation Bar
          if (!isSearching && !isNavigating) _buildTopBar(),

          // Navigation Banner
          if (isNavigating) _buildNavigationBanner(),

          // Side Controls
          if (!isSearching) _buildSideControls(),

          // Info Cards
          if (showDetail && !isNavigating && selectedLocation != null) _buildDetailCard(),
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
            _buildCategoryButton(Icons.shopping_bag_outlined, "Shopping"),
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
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _buildSideControls() {
    return Stack(
      children: [
        Positioned(
          left: 20,
          top: MediaQuery.of(context).size.height * 0.35,
          child: Column(
            children: [
              _buildFloorButton("2", false),
              const SizedBox(height: 12),
              _buildFloorButton("1", true),
              const SizedBox(height: 12),
              _buildFloorButton("-1", false),
            ],
          ),
        ),
        Positioned(
          right: 20,
          top: MediaQuery.of(context).size.height * 0.38,
          child: Column(
            children: [
              _buildRoundIconButton(Icons.add, Colors.white),
              const SizedBox(height: 12),
              _buildRoundIconButton(Icons.remove, Colors.white),
            ],
          ),
        ),
        Positioned(
          right: 20,
          bottom: showDetail || isNavigating ? 230 : 130,
          child: _buildRoundIconButton(Icons.my_location, Colors.white, onTap: () {
            if (selectedLocation == null) {
                setState(() => selectedLocation = locations[0]);
            }
            setState(() => showDetail = !showDetail);
          }),
        ),
      ],
    );
  }

  Widget _buildFloorButton(String label, bool active) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.white.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.black : Colors.black45,
            fontWeight: FontWeight.bold,
            fontSize: 16,
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
          Container(
            width: 50,
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffF6C445), width: 4),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          CustomPaint(
            painter: ViewConePainter(),
            size: const Size(120, 120),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard() {
    return Positioned(
      bottom: 110,
      left: 16,
      right: 16,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedLocation?.title ?? "",
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey, size: 28),
                      onPressed: () => setState(() => showDetail = false),
                    )
                  ],
                ),
                Text(selectedLocation?.category ?? "", 
                  style: const TextStyle(color: Colors.grey, fontSize: 16)),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _buildSquareIcon(Icons.share_outlined),
                    const SizedBox(width: 16),
                    _buildSquareIcon(Icons.bookmark_outlined),
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
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              decoration: const BoxDecoration(
                color: Color(0xffF6C445),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Build a route", 
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
                  Icon(Icons.north_east, size: 24),
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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, size: 24, color: Colors.black),
    );
  }

  Widget _buildSearchOverlay() {
    return Container(
      color: const Color(0xff071B2E),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Color(0xffF6C445), size: 28),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      onChanged: (val) => setState(() => searchQuery = val),
                      cursorColor: Color(0xffF6C445),
                      style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
                      decoration: const InputDecoration(
                        hintText: "Where do you want to go?",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 22),
                        border: InputBorder.none,
                      ),
                      autofocus: true,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                        isSearching = false;
                        searchQuery = "";
                    }),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, color: Colors.black, size: 20),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Text(
                      searchQuery.isEmpty ? "You have already looked" : "Search results", 
                      style: const TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w500)
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredLocations.length,
                        itemBuilder: (context, index) {
                            final loc = filteredLocations[index];
                            return _buildSearchItem(loc);
                        },
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

  Widget _buildSearchItem(MapLocation loc) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
              setState(() {
                  selectedLocation = loc;
                  isSearching = false;
                  showDetail = true;
                  searchQuery = "";
              });
          },
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(loc.title, 
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, letterSpacing: -0.5)),
                      const SizedBox(height: 6),
                      Text(loc.distance, 
                        style: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                const Icon(Icons.north_east, color: Color(0xffF6C445), size: 28),
              ],
            ),
          ),
        ),
        const Divider(height: 1, color: Color(0xffEEEEEE)),
      ],
    );
  }

  Widget _buildNavigationBanner() {
    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xffF6C445),
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Row(
          children: [
            Icon(Icons.turn_left, size: 40),
            SizedBox(width: 20),
            Text(
              "100 m turn left",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationInfoCard() {
    return Positioned(
      bottom: 110,
      left: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavStat("10:00", "Arrival"),
                Container(width: 1.5, height: 45, color: const Color(0xffEEEEEE)),
                _buildNavStat("1 km", "Distance"),
                Container(width: 1.5, height: 45, color: const Color(0xffEEEEEE)),
                _buildNavStat("5 min", "On the way"),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Cancel", 
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                GestureDetector(
                  onTap: () => setState(() => isNavigating = false),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, size: 20),
                  ),
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
        Text(value, 
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        Text(label, 
          style: const TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w500)),
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
          Colors.white.withOpacity(0.4),
          Colors.white.withOpacity(0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    path.moveTo(size.width / 2, size.height);
    path.lineTo(size.width * 0.1, 0);
    path.lineTo(size.width * 0.9, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
