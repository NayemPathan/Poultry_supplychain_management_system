import 'package:flutter/material.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_card.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:poultry_supply_chain_app/auth/auth_provider.dart';

class FarmerDashboardScreen extends StatelessWidget {
  const FarmerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Provider.of<AuthProvider>(context, listen: false).logout();
              context.go('/login');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Text(
                'Farmer Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Create Stock'),
              onTap: () {
                context.go('/farmer/create-stock');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.update),
              title: const Text('Update Farm Stock'),
              onTap: () {
                context.go('/farmer/update-stock');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.business),
              title: const Text('View Linked Businesses'),
              onTap: () {
                context.go('/farmer/view-businesses');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text('Owner Orders'),
              onTap: () {
                context.go('/farmer/owner-orders');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('Chat/Inquiry'),
              onTap: () {
                context.go('/farmer/chat-inquiry');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Welcome Message
            Consumer<AuthProvider>(
              builder: (context, authProvider, _) => Text(
                'Welcome',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 24),

            // Stats Cards
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildStatCard(
                  context,
                  icon: Icons.inventory,
                  value: '150 kg',
                  label: 'Available Stock',
                  color: Colors.green,
                ),
                _buildStatCard(
                  context,
                  icon: Icons.request_quote,
                  value: '₹12,500',
                  label: 'Total Earnings',
                  color: Colors.blue,
                ),
                _buildStatCard(
                  context,
                  icon: Icons.pending_actions,
                  value: '5',
                  label: 'Pending Orders',
                  color: Colors.orange,
                ),
                _buildStatCard(
                  context,
                  icon: Icons.business,
                  value: '3',
                  label: 'Linked Businesses',
                  color: Colors.purple,
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
  Widget _buildStatCard(
      BuildContext context, {
        required IconData icon,
        required String value,
        required String label,
        required Color color,
      }) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}