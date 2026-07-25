import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

// ==========================================
// 1. APP COLORS SETUP
// ==========================================
class AppColors {
  AppColors._();

  static const Color navy = Color(0xFF1E3A75);
  static const Color lavender = Color(0xFFE8E9FB);
  static const Color coral = Color(0xFFEE8267);
  static const Color coralSoft = Color(0xFFF3A98A);
  static const Color coralDeep = Color(0xFFE2694A);
  static const Color gray = Color(0xFF8892A6);
  static const Color border = Color(0xFFE4E7F5);
  static const Color blue = Color(0xFF2954E8);
}

// ==========================================
// MODEL FOR MOCK DELIVERIES
// ==========================================
class DeliveryItem {
  final String store;
  final String location; // Always Île-de-France towns
  final double amount;   // Maximum €6.49
  final String dateStr;  // Max 5 days ago
  final String size;
  final bool isFrozen;

  const DeliveryItem({
    required this.store,
    required this.location,
    required this.amount,
    required this.dateStr,
    required this.size,
    required this.isFrozen,
  });
}

// 5 Days Ago max relative to July 2026
const List<DeliveryItem> mockDeliveries = [
  DeliveryItem(
    store: 'E.Leclerc Drive',
    location: 'Melun, Île-de-France',
    amount: 6.20,
    dateStr: '2 days ago',
    size: 'M',
    isFrozen: false,
  ),
  DeliveryItem(
    store: 'Carrefour Market',
    location: 'Versailles, Île-de-France',
    amount: 5.80,
    dateStr: '3 days ago',
    size: 'L',
    isFrozen: true,
  ),
  DeliveryItem(
    store: 'Auchan Supermarché',
    location: 'Évry, Île-de-France',
    amount: 6.45,
    dateStr: '1 day ago',
    size: 'S',
    isFrozen: false,
  ),
  DeliveryItem(
    store: 'Intermarché',
    location: 'Paris 15e, Île-de-France',
    amount: 4.90,
    dateStr: '4 days ago',
    size: 'M',
    isFrozen: true,
  ),
];

// ==========================================
// 2. MAIN APP ENTRY & ROUTING CONTROL
// ==========================================
void main() {
  runApp(const ShopopopCloneApp());
}

class ShopopopCloneApp extends StatelessWidget {
  const ShopopopCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopopop Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF0F1F5),
        useMaterial3: true,
      ),
      home: const ShopopopClone(),
    );
  }
}

class _NavItem {
  final String id;
  final String label;
  final IconData icon;
  const _NavItem(this.id, this.label, this.icon);
}

const List<_NavItem> _navItems = [
  _NavItem('search', 'Search', LucideIcons.search),
  _NavItem('deliveries', 'My deliveries', LucideIcons.shoppingBag),
  _NavItem('wallet', 'My wallet', LucideIcons.wallet),
  _NavItem('help', 'Help', LucideIcons.messageCircle),
  _NavItem('account', 'My account', LucideIcons.user),
];

class ShopopopClone extends StatefulWidget {
  const ShopopopClone({super.key});

  @override
  State<ShopopopClone> createState() => _ShopopopCloneState();
}

class _ShopopopCloneState extends State<ShopopopClone> {
  String screen = 'deliveries';
  String tab = 'ongoing';

  Widget _buildScreen() {
    switch (screen) {
      case 'wallet':
        return const WalletScreen();
      case 'search':
        return const SearchScreen();
      case 'help':
        return const HelpScreen();
      case 'account':
        return const AccountScreen();
      case 'deliveries':
      default:
        return DeliveriesScreen(
          tab: tab,
          onTabChanged: (value) => setState(() => tab = value),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F5),
      body: SafeArea(
        child: Center(
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 384),
            height: 760,
            margin: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Expanded(child: _buildScreen()),
                _BottomNav(
                  activeId: screen,
                  onSelect: (id) => setState(() => screen = id),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final String activeId;
  final ValueChanged<String> onSelect;

  const _BottomNav({required this.activeId, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: _navItems.map((item) {
          final bool active = activeId == item.id;
          return Expanded(
            child: InkWell(
              onTap: () => onSelect(item.id),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(item.icon, size: 22, color: active ? AppColors.blue : AppColors.gray),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: active ? AppColors.blue : AppColors.gray,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ==========================================
// 3. ACCOUNT SCREEN COMPONENT
// ==========================================
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  static const List<String> _links = [
    'My personal information',
    'Notifications and alerts',
    'My transport method',
    'About',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
            color: const Color(0xFFFCF6E9),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: CustomPaint(
                    size: const Size(180, 120),
                    painter: _SwooshPainter(),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Nicolau',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.navy),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(color: Color(0xFF3CB878), shape: BoxShape.circle),
                      child: const Icon(LucideIcons.check, size: 12, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('News', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
                    Row(
                      children: [
                        Icon(LucideIcons.bell, size: 14, color: AppColors.blue),
                        SizedBox(width: 4),
                        Text(
                          'All the latest news',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(16),
                    color: const Color(0xFFF4F6FE),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: const BoxDecoration(color: AppColors.coralSoft, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Enjoy summer gift cards!',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.blue),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Convert your earnings into gift cards at your favorite stores now.',
                              style: TextStyle(fontSize: 12, color: AppColors.gray),
                            ),
                          ],
                        ),
                      ),
                      const Icon(LucideIcons.arrowRight, size: 16, color: AppColors.blue),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text('My account', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: AppColors.blue, borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Icon(LucideIcons.barChart3, size: 20, color: Colors.white),
                            SizedBox(height: 24),
                            Text('My dashboard', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: AppColors.coral, borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(LucideIcons.repeat, size: 20, color: Colors.white),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: const Text(
                                'To be completed',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text('My regular trips', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                for (final item in _links)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _AccountRowButton(
                      label: item,
                      icon: LucideIcons.arrowRight,
                      textColor: AppColors.navy,
                      iconColor: AppColors.blue,
                    ),
                  ),
                _AccountRowButton(
                  label: 'Log out',
                  icon: LucideIcons.power,
                  textColor: AppColors.coralDeep,
                  iconColor: AppColors.coralDeep,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountRowButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color textColor;
  final Color iconColor;

  const _AccountRowButton({
    required this.label,
    required this.icon,
    required this.textColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: textColor)),
          Icon(icon, size: 16, color: iconColor),
        ],
      ),
    );
  }
}

class _SwooshPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFFF3D9A0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final Path path1 = Path()
      ..moveTo(0, 60)
      ..quadraticBezierTo(60, -10, 180, 40);
    canvas.drawPath(path1, paint);

    final Path path2 = Path()
      ..moveTo(20, 100)
      ..quadraticBezierTo(100, 20, 190, 80);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant _SwooshPainter oldDelegate) => false;
}

// ==========================================
// 4. HELP SCREEN COMPONENT
// ==========================================
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  static const List<String> _topics = [
    'My ongoing deliveries',
    'My first steps and my account',
    'My wallet',
    'My completed deliveries',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Help center',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.navy),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "We're here to help you",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.navy),
          ),
          const SizedBox(height: 8),
          const Text(
            "Choose a topic and we'll tell you the best way to contact our team!",
            style: TextStyle(fontSize: 14, color: AppColors.gray),
          ),
          const SizedBox(height: 20),
          for (final topic in _topics)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _HelpRowButton(
                label: topic,
                icon: LucideIcons.arrowRight,
                iconColor: AppColors.blue,
                textColor: AppColors.navy,
              ),
            ),
          const SizedBox(height: 8),
          const Text('See all answers', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: _HelpRowButton(
              label: 'All the FAQ',
              icon: LucideIcons.bookOpen,
              iconColor: AppColors.blue,
              textColor: AppColors.navy,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(LucideIcons.messageCircle, size: 18),
              label: const Text('Continue my chat', style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HelpRowButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final Color textColor;

  const _HelpRowButton({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: textColor),
            ),
          ),
          Icon(icon, size: 16, color: iconColor),
        ],
      ),
    );
  }
}

// ==========================================
// 5. SEARCH SCREEN COMPONENT
// ==========================================
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(LucideIcons.refreshCw, size: 20, color: AppColors.navy),
              Column(
                children: [
                  Text(
                    'Deliveries available',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.navy),
                  ),
                  SizedBox(height: 2),
                  Text('1 / 20', style: TextStyle(fontSize: 12, color: AppColors.gray)),
                ],
              ),
              Icon(LucideIcons.slidersHorizontal, size: 20, color: AppColors.blue),
            ],
          ),
        ),
        const Expanded(child: _MapArea()),
        const _SummaryCard(),
      ],
    );
  }
}

class _MapArea extends StatelessWidget {
  const _MapArea();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFDCEAD6),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double w = constraints.maxWidth;
          final double h = constraints.maxHeight;
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: h * 0.20,
                left: -20,
                right: -20,
                child: Transform.rotate(
                  angle: -6 * math.pi / 180,
                  child: Container(height: 3, color: const Color(0xFFF3D9A0)),
                ),
              ),
              Positioned(
                top: h * 0.55,
                left: -20,
                right: -20,
                child: Transform.rotate(
                  angle: 3 * math.pi / 180,
                  child: Container(height: 3, color: const Color(0xFFF3D9A0)),
                ),
              ),
              Positioned(
                left: w * 0.30,
                top: -20,
                bottom: -20,
                child: Transform.rotate(
                  angle: 8 * math.pi / 180,
                  child: Container(width: 3, color: const Color(0xFFF6E7C4)),
                ),
              ),
              Positioned(
                top: h * 0.58,
                left: w * 0.14,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.blue,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.blue.withOpacity(0.25),
                        blurRadius: 0,
                        spreadRadius: 6,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: h * 0.32,
                right: w * 0.20,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const _PinBadge('B'),
                    const SizedBox(height: 4),
                    Container(width: 2, height: 24, color: AppColors.navy),
                    const SizedBox(height: 4),
                    const _PinBadge('A'),
                  ],
                ),
              ),
              Positioned(
                bottom: h * 0.14,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.navy, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '4.4 km - 9 min',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.navy),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PinBadge extends StatelessWidget {
  final String letter;
  const _PinBadge(this.letter);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.navy, width: 2),
      ),
      child: Text(
        letter,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.navy),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tomorrow', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.navy,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  '€5.50',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(LucideIcons.mapPin, size: 16, color: AppColors.blue),
              SizedBox(width: 8),
              Text('E.Leclerc Drive - Mareuil-lès-Meaux', style: TextStyle(fontSize: 14, color: AppColors.navy)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Icon(LucideIcons.clock, size: 16, color: AppColors.coralDeep),
              SizedBox(width: 8),
              Text('Pick up : 08h15 - 09h00', style: TextStyle(fontSize: 14, color: AppColors.navy)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'Size L',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.blue),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(LucideIcons.snowflake, size: 12, color: AppColors.blue),
                    SizedBox(width: 4),
                    Text('Frozen', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.blue)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 6. WALLET SCREEN COMPONENT
// ==========================================
class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SizedBox(width: 22),
              Text('My wallet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.navy)),
              Icon(LucideIcons.settings, size: 22, color: AppColors.coral),
            ],
          ),
          const SizedBox(height: 24),
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.coralSoft, AppColors.coralDeep],
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    right: -40,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.12)),
                    ),
                  ),
                  Positioned(
                    bottom: -30,
                    left: -20,
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.10)),
                    ),
                  ),
                  // UPDATED: Requested balance close to 145.66 €
                  const Text('€145.65', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _WalletActionCard(icon: LucideIcons.landmark, label: 'Make a bank transfer')),
              const SizedBox(width: 12),
              Expanded(child: _WalletActionCard(icon: LucideIcons.tag, label: 'Convert to a coupon')),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Summary of amounts received', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.navy)),
                Icon(LucideIcons.arrowRight, size: 18, color: AppColors.blue),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Text('Latest transactions', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
          const SizedBox(height: 8),
          const Text('No transactions have been recently made', style: TextStyle(fontSize: 14, color: AppColors.gray)),
        ],
      ),
    );
  }
}

class _WalletActionCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const _WalletActionCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Icon(icon, size: 22, color: AppColors.blue),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.navy)),
        ],
      ),
    );
  }
}

// ==========================================
// 7. DELIVERIES SCREEN COMPONENT
// ==========================================
class DeliveriesScreen extends StatelessWidget {
  final String tab;
  final ValueChanged<String> onTabChanged;

  const DeliveriesScreen({
    super.key,
    required this.tab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOngoing = tab == 'ongoing';

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(LucideIcons.refreshCw, size: 20, color: AppColors.navy),
              Text('My deliveries', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.navy)),
              SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(color: AppColors.lavender, borderRadius: BorderRadius.circular(999)),
            child: Row(
              children: [
                Expanded(child: _tabButton('Ongoing', 'ongoing')),
                Expanded(child: _tabButton('Completed', 'completed')),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // UPDATED: Now lists items if ongoing instead of empty fallback text
          Expanded(
            child: isOngoing
                ? ListView.builder(
                    itemCount: mockDeliveries.length,
                    itemBuilder: (context, index) {
                      final item = mockDeliveries[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColors.border),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.store,
                                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.lavender,
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Text(
                                    '€${item.amount.toStringAsFixed(2)}',
                                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.blue, fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(LucideIcons.mapPin, size: 14, color: AppColors.gray),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    item.location,
                                    style: const TextStyle(fontSize: 13, color: AppColors.navy),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(LucideIcons.clock, size: 14, color: AppColors.coral),
                                const SizedBox(width: 6),
                                Text(
                                  item.dateStr,
                                  style: const TextStyle(fontSize: 12, color: AppColors.gray),
                                ),
                                const Spacer(),
                                if (item.isFrozen) ...[
                                  const Icon(LucideIcons.snowflake, size: 12, color: AppColors.blue),
                                  const SizedBox(width: 4),
                                ],
                                Text(
                                  'Size ${item.size}',
                                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.gray),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 112,
                          height: 112,
                          decoration: const BoxDecoration(color: AppColors.lavender, shape: BoxShape.circle),
                          child: const Icon(LucideIcons.check, size: 48, color: AppColors.coral),
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          'No completed deliveries yet',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.navy),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Your delivery history will show up here',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: AppColors.gray),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _tabButton(String label, String value) {
    final bool active = tab == value;
    return GestureDetector(
      onTap: () => onTabChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.navy),
        ),
      ),
    );
  }
}
