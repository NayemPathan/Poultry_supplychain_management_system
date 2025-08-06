import 'package:flutter/material.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_card.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:poultry_supply_chain_app/auth/auth_provider.dart';

class EmployeeDashboardScreen extends StatelessWidget {
  const EmployeeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Dashboard'),
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
                'Employee Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Assigned Orders'),
              onTap: () {
                context.go('/employee/assigned-orders');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Pick up orders'),
              onTap: () {
                context.go('/employee/pickup-orders');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delivery_dining),
              title: const Text('Delivery Orders'),
              onTap: () {
                context.go('/employee/delivery-orders');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Mark Payment Received'),
              onTap: () {
                context.go('/employee/mark-payment');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile & Schedule'),
              onTap: () {
                context.go('/employee/profile-schedule');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatCard(
              context,
              icon: Icons.local_shipping,
              value: '3',
              label: 'Active Collections',
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            _buildStatCard(
              context,
              icon: Icons.delivery_dining,
              value: '5',
              label: 'Pending Deliveries',
              color: Colors.orange,
            ),
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