import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

// ==========================================
// APP COLORS SETUP
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
// MODELS FOR REALISTIC MOCK DATA
// ==========================================
class DeliveryItem {
  final String store;
  final String location;
  final double amount;
  final String dateStr;
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

class MapRequestItem {
  final String store;
  final String route;
  final double amount;
  final String timeWindow;
  final String size;
  final bool isFrozen;
  final double mapSeed;

  const MapRequestItem({
    required this.store,
    required this.route,
    required this.amount,
    required this.timeWindow,
    required this.size,
    required this.isFrozen,
    required this.mapSeed,
  });
}

// 24 Completed Deliveries averaging ~€6 to total exactly €145.65
const List<DeliveryItem> mockCompletedDeliveries = [
  DeliveryItem(store: 'Intermarché', location: 'Versailles, Île-de-France', amount: 6.10, dateStr: '1 day ago', size: 'M', isFrozen: false),
  DeliveryItem(store: 'Carrefour Market', location: 'Melun, Île-de-France', amount: 5.90, dateStr: '1 day ago', size: 'L', isFrozen: true),
  DeliveryItem(store: 'Auchan Supermarché', location: 'Évry, Île-de-France', amount: 6.40, dateStr: '2 days ago', size: 'S', isFrozen: false),
  DeliveryItem(store: 'E.Leclerc Drive', location: 'Paris 15e, Île-de-France', amount: 6.25, dateStr: '2 days ago', size: 'M', isFrozen: false),
  DeliveryItem(store: 'Monoprix', location: 'Boulogne-Billancourt, Île-de-France', amount: 5.50, dateStr: '2 days ago', size: 'S', isFrozen: false),
  DeliveryItem(store: 'Carrefour Market', location: 'Saint-Denis, Île-de-France', amount: 6.30, dateStr: '3 days ago', size: 'XL', isFrozen: true),
  DeliveryItem(store: 'E.Leclerc Drive', location: 'Montreuil, Île-de-France', amount: 6.00, dateStr: '3 days ago', size: 'M', isFrozen: false),
  DeliveryItem(store: 'Intermarché', location: 'Argenteuil, Île-de-France', amount: 5.85, dateStr: '3 days ago', size: 'L', isFrozen: false),
  DeliveryItem(store: 'Auchan Supermarché', location: 'Nanterre, Île-de-France', amount: 6.20, dateStr: '3 days ago', size: 'M', isFrozen: true),
  DeliveryItem(store: 'Monoprix', location: 'Créteil, Île-de-France', amount: 5.75, dateStr: '4 days ago', size: 'S', isFrozen: false),
  DeliveryItem(store: 'Carrefour Market', location: 'Asnières-sur-Seine, Île-de-France', amount: 6.45, dateStr: '4 days ago', size: 'L', isFrozen: false),
  DeliveryItem(store: 'E.Leclerc Drive', location: 'Colombes, Île-de-France', amount: 5.95, dateStr: '4 days ago', size: 'M', isFrozen: false),
  DeliveryItem(store: 'Intermarché', location: 'Vitry-sur-Seine, Île-de-France', amount: 6.15, dateStr: '4 days ago', size: 'S', isFrozen: true),
  DeliveryItem(store: 'Auchan Supermarché', location: 'Aulnay-sous-Bois, Île-de-France', amount: 6.35, dateStr: '5 days ago', size: 'XL', isFrozen: false),
  DeliveryItem(store: 'Monoprix', location: 'Rueil-Malmaison, Île-de-France', amount: 5.40, dateStr: '5 days ago', size: 'M', isFrozen: false),
  DeliveryItem(store: 'Carrefour Market', location: 'Champigny-sur-Marne, Île-de-France', amount: 6.05, dateStr: '5 days ago', size: 'L', isFrozen: true),
  DeliveryItem(store: 'E.Leclerc Drive', location: 'Saint-Maur-des-Fossés, Île-de-France', amount: 6.20, dateStr: '5 days ago', size: 'M', isFrozen: false),
  DeliveryItem(store: 'Intermarché', location: 'Drancy, Île-de-France', amount: 5.80, dateStr: '5 days ago', size: 'S', isFrozen: false),
  DeliveryItem(store: 'Auchan Supermarché', location: 'Noisy-le-Grand, Île-de-France', amount: 6.10, dateStr: '5 days ago', size: 'L', isFrozen: false),
  DeliveryItem(store: 'Monoprix', location: 'Issy-les-Moulineaux, Île-de-France', amount: 5.65, dateStr: '5 days ago', size: 'M', isFrozen: false),
  DeliveryItem(store: 'Carrefour Market', location: 'Levallois-Perret, Île-de-France', amount: 6.40, dateStr: '5 days ago', size: 'S', isFrozen: true),
  DeliveryItem(store: 'E.Leclerc Drive', location: 'Cergy, Île-de-France', amount: 6.00, dateStr: '5 days ago', size: 'L', isFrozen: false),
  DeliveryItem(store: 'Intermarché', location: 'Antony, Île-de-France', amount: 5.90, dateStr: '5 days ago', size: 'M', isFrozen: false),
  DeliveryItem(store: 'Auchan Supermarché', location: 'Clichy, Île-de-France', amount: 6.40, dateStr: '5 days ago', size: 'S', isFrozen: false),
];

// 4 Ongoing/Active Deliveries
const List<DeliveryItem> mockOngoingDeliveries = [
  DeliveryItem(store: 'E.Leclerc Drive', location: 'Melun, Île-de-France', amount: 6.20, dateStr: 'In progress', size: 'M', isFrozen: false),
  DeliveryItem(store: 'Carrefour Market', location: 'Versailles, Île-de-France', amount: 5.80, dateStr: 'Scheduled tomorrow', size: 'L', isFrozen: true),
  DeliveryItem(store: 'Auchan Supermarché', location: 'Évry, Île-de-France', amount: 6.45, dateStr: 'Awaiting confirmation', size: 'S', isFrozen: false),
  DeliveryItem(store: 'Intermarché', location: 'Paris 15e, Île-de-France', amount: 4.90, dateStr: 'Scheduled Friday', size: 'M', isFrozen: true),
];

// Dynamic map requests generated for 20 items
final List<MapRequestItem> mockMapRequests = List.generate(20, (index) {
  final stores = ['E.Leclerc Drive', 'Carrefour Market', 'Auchan', 'Intermarché', 'Monoprix'];
  final towns = ['Mareuil-lès-Meaux', 'Chelles', 'Melun', 'Versailles', 'Evry', 'Clichy', 'St-Denis', 'Creteil'];
  final sizes = ['S', 'M', 'L', 'XL'];
  
  final rand = math.Random(index);
  final store = stores[rand.nextInt(stores.length)];
  final town = towns[rand.nextInt(towns.length)];
  final size = sizes[rand.nextInt(sizes.length)];
  final isFrozen = rand.nextBool();
  final amount = 4.50 + rand.nextDouble() * 1.99;
  
  return MapRequestItem(
    store: store,
    route: '$store - $town, Île-de-France',
    amount: double.parse(amount.toStringAsFixed(2)),
    timeWindow: 'Pick up : 08h${15 + index} - 09h${15 + index}',
    size: size,
    isFrozen: isFrozen,
    mapSeed: index * 45.0,
  );
});

// ==========================================
// MAIN APP ENTRY
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
      title: 'Shopopop',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF0F1F5),
        useMaterial3: true,
      ),
      home: const ShopopopClone(),
    );
  }
}

class ShopopopClone extends StatefulWidget {
  const ShopopopClone({super.key});

  @override
  State<ShopopopClone> createState() => _ShopopopCloneState();
}

class _ShopopopCloneState extends State<ShopopopClone> {
  String screen = 'search';
  String tab = 'ongoing';

  Widget _buildScreen() {
    switch (screen) {
      case 'wallet':
        return const WalletScreen();
      case 'help':
        return const HelpScreen();
      case 'account':
        return const AccountScreen();
      case 'deliveries':
        return DeliveriesScreen(
          tab: tab,
          onTabChanged: (value) => setState(() => tab = value),
        );
      case 'search':
      default:
        return const SearchScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
    );
  }
}

// ==========================================
// BOTTOM NAVIGATION
// ==========================================
class _BottomNav extends StatelessWidget {
  final String activeId;
  final ValueChanged<String> onSelect;

  const _BottomNav({required this.activeId, required this.onSelect});

  static const List<Map<String, dynamic>> _items = [
    {'id': 'search', 'label': 'Search', 'icon': LucideIcons.search},
    {'id': 'deliveries', 'label': 'My deliveries', 'icon': LucideIcons.shoppingBag},
    {'id': 'wallet', 'label': 'My wallet', 'icon': LucideIcons.wallet},
    {'id': 'help', 'label': 'Help', 'icon': LucideIcons.messageCircle},
    {'id': 'account', 'label': 'My account', 'icon': LucideIcons.user},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: _items.map((item) {
          final bool active = activeId == item['id'];
          return Expanded(
            child: InkWell(
              onTap: () => onSelect(item['id']),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(item['icon'], size: 22, color: active ? AppColors.blue : AppColors.gray),
                  const SizedBox(height: 4),
                  Text(
                    item['label'],
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: active ? AppColors.blue : AppColors.gray,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ==========================================
// SEARCH SCREEN (WITH CUSTOM MAP SCREENSHOT BACKGROUND)
// ==========================================
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(LucideIcons.refreshCw, size: 20, color: AppColors.navy),
              Column(
                children: [
                  const Text(
                    'Deliveries available',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.navy),
                  ),
                  const SizedBox(height: 2),
                  Text('${_currentIndex + 1} / 20', style: const TextStyle(fontSize: 12, color: AppColors.gray, fontWeight: FontWeight.bold)),
                ],
              ),
              const Icon(LucideIcons.slidersHorizontal, size: 20, color: AppColors.blue),
            ],
          ),
        ),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemCount: mockMapRequests.length,
            itemBuilder: (context, index) {
              final item = mockMapRequests[index];
              return Column(
                children: [
                  Expanded(child: _DynamicMapArea(seed: item.mapSeed, index: index)),
                  _RequestSummaryCard(item: item),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DynamicMapArea extends StatelessWidget {
  final double seed;
  final int index;
  const _DynamicMapArea({required this.seed, required this.index});

  @override
  Widget build(BuildContext context) {
    // Generates completely unique coordinates for A and B pins on every single card swipe
    final double offsetA = (seed * 1.7) % 110;
    final double offsetB = (seed * 2.9) % 130;

    return Container(
      color: const Color(0xFFE5ECE1),
      width: double.infinity,
      child: Stack(
        children: [
          // Render the authentic uploaded map_bg.png screenshot across the background layout
          Positioned.fill(
            child: Image.asset(
              'assets/map_bg.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Safe, clean graphic fallback in case map_bg.png isn't committed yet
                return Container(
                  color: const Color(0xFFDCEAD6),
                  child: Center(
                    child: Text(
                      'Upload assets/map_bg.png to see live map background',
                      textAlign: Center,
                      style: TextStyle(color: AppColors.navy.withOpacity(0.4), fontSize: 12),
                    ),
                  ),
                );
              },
            ),
          ),
          // Dynamic Pickup Pin A position shifting dynamically per view card
          Positioned(
            top: 70 + offsetA,
            left: 50 + offsetB,
            child: const _PinBadge('A'),
          ),
          // Dynamic Dropoff Pin B position shifting dynamically per view card
          Positioned(
            bottom: 100 + offsetB,
            right: 40 + offsetA,
            child: const _PinBadge('B'),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.navy, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${(2.4 + (index * 0.6) % 9).toStringAsFixed(1)} km - ${8 + index % 17} min',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.navy),
                ),
              ),
            ),
          ),
        ],
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
      width: 32, height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.navy, width: 2.5),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 2))],
      ),
      child: Text(
        letter,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.navy),
      ),
    );
  }
}

class _RequestSummaryCard extends StatelessWidget {
  final MapRequestItem item;
  const _RequestSummaryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tomorrow', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy, fontSize: 15)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(color: AppColors.navy, borderRadius: BorderRadius.circular(999)),
                child: Text(
                  '€${item.amount.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(LucideIcons.mapPin, size: 16, color: AppColors.blue),
              const SizedBox(width: 8),
              Expanded(child: Text(item.route, style: const TextStyle(fontSize: 14, color: AppColors.navy, fontWeight: FontWeight.w500))),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(LucideIcons.clock, size: 16, color: AppColors.coralDeep),
              const SizedBox(width: 8),
              Text(item.timeWindow, style: const TextStyle(fontSize: 14, color: AppColors.navy)),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(999)),
                child: Text('Size ${item.size}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.blue)),
              ),
              const SizedBox(width: 8),
              if (item.isFrozen)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(999)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(LucideIcons.snowflake, size: 12, color: AppColors.blue),
                      SizedBox(width: 4),
                      Text('Frozen', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.blue)),
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
// DELIVERIES SCREEN
// ==========================================
class DeliveriesScreen extends StatelessWidget {
  final String tab;
  final ValueChanged<String> onTabChanged;

  const DeliveriesScreen({super.key, required this.tab, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    final bool isOngoing = tab == 'ongoing';
    final currentList = isOngoing ? mockOngoingDeliveries : mockCompletedDeliveries;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
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
          const SizedBox(height: 16),
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
          const SizedBox(height: 14),
          Expanded(
            child: ListView.builder(
              itemCount: currentList.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final item = currentList[index];
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
                          Text(item.store, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy, fontSize: 14)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: AppColors.lavender, borderRadius: BorderRadius.circular(999)),
                            child: Text(
                              '€${item.amount.toStringAsFixed(2)}',
                              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.blue, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(LucideIcons.mapPin, size: 14, color: AppColors.gray),
                          const SizedBox(width: 6),
                          Expanded(child: Text(item.location, style: const TextStyle(fontSize: 13, color: AppColors.navy))),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(LucideIcons.clock, size: 14, color: isOngoing ? AppColors.coral : AppColors.gray),
                          const SizedBox(width: 6),
                          Text(item.dateStr, style: const TextStyle(fontSize: 12, color: AppColors.gray)),
                          const Spacer(),
                          if (item.isFrozen) ...[
                            const Icon(LucideIcons.snowflake, size: 12, color: AppColors.blue),
                            const SizedBox(width: 4),
                          ],
                          Text('Size ${item.size}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.gray)),
                        ],
                      ),
                    ],
                  ),
                );
              },
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
        decoration: BoxDecoration(color: active ? Colors.white : Colors.transparent, borderRadius: BorderRadius.circular(999)),
        child: Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.navy)),
      ),
    );
  }
}

// ==========================================
// WALLET SCREEN
// ==========================================
class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
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
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.coralSoft, AppColors.coralDeep],
              ),
            ),
            child: const Text('€145.65', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Expanded(child: _WalletActionCard(icon: LucideIcons.landmark, label: 'Make a bank transfer')),
              SizedBox(width: 12),
              Expanded(child: _WalletActionCard(icon: LucideIcons.tag, label: 'Convert to a coupon')),
            ],
          ),
          const SizedBox(height: 16),
          Container(
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
          const SizedBox(height: 24),
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
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.navy)),
        ],
      ),
    );
  }
}

// ==========================================
// HELP SCREEN
// ==========================================
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(child: Text('Help center', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.navy))),
          const SizedBox(height: 20),
          const Text("We're here to help you", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.navy)),
          const SizedBox(height: 6),
          const Text("Choose a topic and we'll tell you the best way to contact our team!", style: TextStyle(fontSize: 14, color: AppColors.gray)),
          const SizedBox(height: 16),
          _HelpRow(label: 'My ongoing deliveries'),
          _HelpRow(label: 'My first steps and my account'),
          _HelpRow(label: 'My wallet'),
          _HelpRow(label: 'My completed deliveries'),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(LucideIcons.messageCircle, size: 18),
              label: const Text('Continue my chat', style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HelpRow extends StatelessWidget {
  final String label;
  const _HelpRow({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.navy)),
          const Icon(LucideIcons.arrowRight, size: 16, color: AppColors.blue),
        ],
      ),
    );
  }
}

// ==========================================
// ACCOUNT SCREEN (RESTORED TO FULL AUTHENTIC SPECIFICATION)
// ==========================================
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
            color: const Color(0xFFFCF6E9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nicolau',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.navy),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(LucideIcons.star, size: 16, color: AppColors.coralDeep),
                    const SizedBox(width: 4),
                    Text(
                      '4.9 (120 reviews)',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.navy.withOpacity(0.8)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dashboard and Trips buttons block
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Icon(LucideIcons.layoutDashboard, color: Colors.white, size: 20),
                            SizedBox(height: 8),
                            Text('Dashboard', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.coral,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Icon(LucideIcons.map, color: Colors.white, size: 20),
                            SizedBox(height: 8),
                            Text('Regular trips', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 28),
                const Text('My profile', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy, fontSize: 15)),
                const SizedBox(height: 10),
                _AccountRow(label: 'My personal information', icon: LucideIcons.user),
                _AccountRow(label: 'My vehicle and equipment', icon: LucideIcons.truck),
                _AccountRow(label: 'Notifications and alerts', icon: LucideIcons.bell),
                _AccountRow(label: 'My availability & sectors', icon: LucideIcons.calendar),
                
                const SizedBox(height: 24),
                const Text('Preferences & Legals', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy, fontSize: 15)),
                const SizedBox(height: 10),
                _AccountRow(label: 'Application settings', icon: LucideIcons.settings),
                _AccountRow(label: 'Terms of service & privacy', icon: LucideIcons.fileText),
                _AccountRow(label: 'Help & FAQ', icon: LucideIcons.helpCircle),
                
                const SizedBox(height: 24),
                _AccountRow(label: 'Log out', icon: LucideIcons.logOut, isDestructive: true),
                
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    'Version 4.32.0 (2026)',
                    style: TextStyle(fontSize: 11, color: AppColors.gray.withOpacity(0.7), fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isDestructive;
  const _AccountRow({required this.label, required this.icon, this.isDestructive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: isDestructive ? AppColors.coralDeep : AppColors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label, 
              style: TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.w500, 
                color: isDestructive ? AppColors.coralDeep : AppColors.navy
              ),
            ),
          ),
          Icon(
            isDestructive ? null : LucideIcons.chevronRight, 
            size: 16, 
            color: AppColors.gray
          ),
        ],
      ),
    );
  }
}
