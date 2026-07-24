import 'package:flutter/material.dart';

void main() {
  runApp(const ShopopopCloneApp());
}

class ShopopopCloneApp extends StatelessWidget {
  const ShopopopCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF1E3A8A),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
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
  int _currentIndex = 2; 

  final List<Widget> _screens = [
    const SearchMapScreen(),       
    const MyDeliveriesScreen(),    
    const MyWalletScreen(),        
    const HelpCenterScreen(),      
    const MyAccountScreen(),       
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: 'My deliveries'),
          BottomNavigationBarItem(icon: Icon(Icons.euro), label: 'My wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Help'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'My account'),
        ],
      ),
    );
  }
}

class SearchMapScreen extends StatelessWidget {
  const SearchMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deliveries available", style: TextStyle(color: Color(0xFF1B365D), fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.refresh, color: Colors.grey),
        actions: const [Icon(Icons.tune, color: Colors.blue), SizedBox(width: 16)],
      ),
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFE8F5E9),
            child: const Center(
              child: Text("[ Map Visualization Placeholder ]\nBussy-Saint-Georges Area", 
                textAlign: TextAlign.center, style: TextStyle(color: Colors.grey))
            ),
          ),
          Positioned(
            bottom: 180,
            left: 100,
            right: 100,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF1B365D), width: 2),
              ),
              child: const Text("4.4 km - 9 min", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B365D))),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Tomorrow", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B365D))),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(color: const Color(0xFF0F2C59), borderRadius: BorderRadius.circular(20)),
                          child: const Text("€5.50", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      children: [
                        Icon(Icons.store, color: Colors.blue, size: 20),
                        SizedBox(width: 8),
                        Expanded(child: Text("E.Leclerc Drive - Mareuil-lès-Meaux", style: TextStyle(color: Colors.grey))),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.redAccent, size: 20),
                        SizedBox(width: 8),
                        Text("Pick up : 08h15 - 09h00", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildBadge("Size L", Colors.blue.shade50, Colors.blue),
                        const SizedBox(width: 8),
                        _buildBadge("❄ Frozen", Colors.blue.shade50, Colors.blue),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBadge(String label, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Text(label, style: TextStyle(color: textCol, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }
}

class MyDeliveriesScreen extends StatelessWidget {
  const MyDeliveriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My deliveries", style: TextStyle(color: Color(0xFF1B365D), fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.refresh, color: Colors.grey),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(25)),
                    child: const Text("Ongoing", textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF4338CA), fontWeight: FontWeight.bold)),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: const Text("Completed", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(color: Colors.amber.shade100, shape: BoxShape.circle),
                child: const Icon(Icons.people, size: 64, color: Colors.blue),
              ),
              const SizedBox(height: 24),
              const Text("You don't have any upcoming deliveries!", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1B365D))),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text("Join the adventure and make your first delivery ;)", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class MyWalletScreen extends StatelessWidget {
  const MyWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My wallet", style: TextStyle(color: Color(0xFF1B365D), fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [Icon(Icons.settings_outlined, color: Colors.grey), SizedBox(width: 16)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(
                color: const Color(0xFFE2725B), 
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  "€120.45",
                  style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildActionCard(Icons.account_balance, "Make a bank transfer")),
                const SizedBox(width: 12),
                Expanded(child: _buildActionCard(Icons.local_offer_outlined, "Convert to a coupon")),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Summary of amounts received", style: TextStyle(color: Color(0xFF1B365D), fontWeight: FontWeight.w600)),
                  Icon(Icons.arrow_forward, color: Colors.blue, size: 20),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text("Latest transactions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B365D))),
            const SizedBox(height: 8),
            const Text("No transactions have been recently made", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 100,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade100)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help center", style: TextStyle(color: Color(0xFF1B365D), fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("We're here to help you", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1B365D))),
            const SizedBox(height: 8),
            const Text("Choose a topic and we'll tell you the best way to contact our team!", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            _buildMenuRow("My ongoing deliveries"),
            _buildMenuRow("My first steps and my account"),
            _buildMenuRow("My wallet"),
            _buildMenuRow("My completed deliveries"),
            const SizedBox(height: 16),
            const Text("See all answers", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B365D))),
            const SizedBox(height: 12),
            _buildMenuRow("All the FAQ", iconLeft: Icons.book_outlined),
            const Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0066FF),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              icon: const Icon(Icons.chat_bubble, color: Colors.white),
              label: const Text("Continue my chat", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMenuRow(String title, {IconData iconLeft = Icons.none}) {
    return Container(
      margin: const EdgeInsets.bottom(10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
      child: Row(
        children: [
          if (iconLeft != Icons.none) ...[Icon(iconLeft, color: Colors.blue), const SizedBox(width: 12)],
          Expanded(child: Text(title, style: const TextStyle(color: Color(0xFF1B365D), fontWeight: FontWeight.w500))),
          const Icon(Icons.arrow_forward, color: Colors.blue, size: 18),
        ],
      ),
    );
  }
}

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Row(
                children: [
                  Text("Nicolau", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF1B365D))),
                  SizedBox(width: 8),
                  Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("News", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B365D))),
                  TextButton.icon(onPressed: () {}, icon: const Icon(Icons.notifications_none, size: 16), label: const Text("All the latest news"))
                ],
              ),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: const ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.orangeAccent, child: Icon(Icons.card_giftcard, color: Colors.white)),
                  title: Text("Profitez des bons d'achat cet été !", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                  subtitle: Text("Convertissez dès maintenant votre cagnotte en bons d'achat dans vos ens..."),
                  trailing: Icon(Icons.arrow_forward, color: Colors.blue),
                ),
              ),
              const SizedBox(height: 24),
              const Text("My account", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B365D))),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildColorDashboardCard("My dashboard", const Color(0xFF0066FF), Icons.bar_chart)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildColorDashboardCard("My regular trips", const Color(0xFFF28E79), Icons.swap_calls, tag: "To be completed")),
                ],
              ),
              const SizedBox(height: 16),
              _buildSimpleMenuRow("My personal information"),
              _buildSimpleMenuRow("Notifications and alerts"),
              _buildSimpleMenuRow("My transport method"),
              _buildSimpleMenuRow("About"),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.power_settings_new, color: Colors.redAccent),
                title: const Text("Log out", style: TextStyle(color: Color(0xFF1B365D), fontWeight: FontWeight.bold)),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorDashboardCard(String title, Color bgColor, IconData icon, {String tag = ""}) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 110,
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (tag.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(6)),
                  child: Text(tag, style: const TextStyle(color: Colors.white, fontSize: 10)),
                )
              else
                const SizedBox(),
              Icon(icon, color: Colors.white.withOpacity(0.8)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSimpleMenuRow(String label) {
    return Container(
      margin: const EdgeInsets.bottom(10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF1B365D), fontWeight: FontWeight.w500)),
          const Icon(Icons.arrow_forward, color: Colors.blue, size: 18),
        ],
      ),
    );
  }
}
