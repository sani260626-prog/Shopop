import 'package:flutter/material.dart';

void main() {
  runApp(const ShopopopApp());
}

class ShopopopApp extends StatelessWidget {
  const ShopopopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopopop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF1E3A8A),
        scaffoldBackgroundColor: const Color(0xFFF3F4F6),
        fontFamily: 'Roboto',
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const MapScreen(),
    const DeliveriesScreen(),
    const WalletScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1E3A8A),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), activeIcon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping_outlined), activeIcon: Icon(Icons.local_shipping), label: 'Deliveries'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), activeIcon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// ==========================================
// 1. MAP SCREEN (With Realistic Graphics)
// ==========================================
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: const Color(0xFFE5E7EB),
            child: CustomPaint(painter: MapBackgroundPainter()),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for deliveries near you...',
                      prefixIcon: Icon(Icons.search, color: Color(0xFF1E3A8A)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ==========================================
// 2. DELIVERIES SCREEN
// ==========================================
class DeliveriesScreen extends StatelessWidget {
  const DeliveriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Deliveries', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E3A8A),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDeliveryCard(
            title: 'Order #4829 - Grocery Delivery',
            status: 'In Progress',
            statusColor: Colors.orange,
            payout: '\$14.50',
            address: '123 Main Street, Downtown',
          ),
          const SizedBox(height: 12),
          _buildDeliveryCard(
            title: 'Order #4711 - Florist Express',
            status: 'Completed',
            statusColor: Colors.green,
            payout: '\$9.20',
            address: '742 Evergreen Terrace',
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryCard({required String title, required String status, required Color statusColor, required String payout, required String address}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(payout, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A), fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(address, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: ContainerDecorationHelper.statusBadge(statusColor),
              child: Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12)),
            )
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 3. WALLET SCREEN
// ==========================================
class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wallet', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E3A8A),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF1E3A8A),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Available Balance', style: TextStyle(color: Colors.white70, fontSize: 16)),
                const SizedBox(height: 8),
                const Text('\$142.80', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF97316),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  ),
                  child: const Text('Cash Out to Bank', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text('Recent Transactions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 16),
                _buildTransactionItem('Payout: Order #4711', '+\$9.20', 'July 24', Colors.green),
                _buildTransactionItem('Bank Transfer', '-\$50.00', 'July 20', Colors.black87),
                _buildTransactionItem('Payout: Order #4690', '+\$22.40', 'July 19', Colors.green),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTransactionItem(String title, String amount, String date, Color amountColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              const SizedBox(height: 4),
              Text(date, style: const TextStyle(color: Colors.grey, fontSize: 13)),
            ],
          ),
          Text(amount, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: amountColor)),
        ],
      ),
    );
  }
}

// ==========================================
// 4. PROFILE SCREEN
// ==========================================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFF1E3A8A),
                child: Icon(Icons.person, size: 55, color: Colors.white),
              ),
              const SizedBox(height: 16),
              const Text('Driver Profile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
              const Text('driver@shopopop.com', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 32),
              _buildProfileTile(Icons.verified_user, 'Account Verification', 'Verified'),
              _buildProfileTile(Icons.directions_car, 'Vehicle Information', 'Toyota Prius (White)'),
              _buildProfileTile(Icons.settings, 'App Settings', ''),
              _buildProfileTile(Icons.help_outline, 'Help & Support', ''),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {},
                child: const Text('Log Out', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileTile(IconData icon, String title, String trailingText) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF1E3A8A)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailingText.isNotEmpty) Text(trailingText, style: const TextStyle(color: Colors.grey)),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// STATIC CITY MAP GRAPHICS GENERATOR
// ==========================================
class MapBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw Waterway
    paint.color = Colors.blue.withOpacity(0.25);
    paint.strokeWidth = 45;
    final riverPath = Path()
      ..moveTo(0, size.height * 0.3)
      ..quadraticBezierTo(size.width * 0.3, size.height * 0.35, size.width * 0.5, size.height * 0.6)
      ..lineTo(size.width, size.height * 0.75);
    canvas.drawPath(riverPath, paint);

    // Main Expressways
    paint.color = Colors.white;
    paint.strokeWidth = 16;
    canvas.drawLine(Offset(0, size.height * 0.45), Offset(size.width, size.height * 0.5), paint);
    canvas.drawLine(Offset(size.width * 0.35, 0), Offset(size.width * 0.35, size.height), paint);

    paint.color = Colors.orange.withOpacity(0.35);
    paint.strokeWidth = 10;
    canvas.drawLine(Offset(0, size.height * 0.45), Offset(size.width, size.height * 0.5), paint);
    canvas.drawLine(Offset(size.width * 0.35, 0), Offset(size.width * 0.35, size.height), paint);

    // City Streets
    paint.color = Colors.white;
    paint.strokeWidth = 6;
    canvas.drawLine(Offset(0, size.height * 0.2), Offset(size.width, size.height * 0.2), paint);
    canvas.drawLine(Offset(0, size.height * 0.75), Offset(size.width, size.height * 0.7), paint);
    canvas.drawLine(Offset(size.width * 0.75, 0), Offset(size.width * 0.75, size.height), paint);

    // Map Location Markers
    _drawPin(canvas, Offset(size.width * 0.28, size.height * 0.38), const Color(0xFFFF4757));
    _drawPin(canvas, Offset(size.width * 0.60, size.height * 0.55), const Color(0xFF1E3A8A));
    _drawPin(canvas, Offset(size.width * 0.80, size.height * 0.22), const Color(0xFFFF4757));
  }

  void _drawPin(Canvas canvas, Offset position, Color color) {
    canvas.drawCircle(Offset(position.dx, position.dy + 2), 5, Paint()..color = Colors.black12);
    canvas.drawCircle(position, 9, Paint()..color = color);
    canvas.drawCircle(position, 3.5, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Helper class for safe decoration properties
class ContainerDecorationHelper {
  static BoxDecoration statusBadge(Color statusColor) {
    return BoxDecoration(
      color: statusColor.withOpacity(0.15),
      borderRadius: BorderRadius.circular(6),
    );
  }
}
