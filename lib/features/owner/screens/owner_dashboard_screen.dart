import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:poultry_supply_chain_app/auth/auth_provider.dart';

class OwnerDashboardScreen extends StatelessWidget {
  const OwnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Owner Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Provider.of<AuthProvider>(context, listen: false).logout();
              context.go('/login'); // Redirect to login after logout
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
                'Owner Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.business),
              title: const Text('Business Management'),
              onTap: () {
                context.go('/owner/business-management');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Staff Management'),
              onTap: () {
                context.go('/owner/staff-management');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Customer Management'),
              onTap: () {
                context.go('/owner/customer-management');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.agriculture),
              title: const Text('Farmer Management'),
              onTap: () {
                context.go('/owner/farmer-management');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Customer Orders'),
              onTap: () {
                context.go('/owner/customer-orders');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_shipping),
              title: const Text('Collections'),
              onTap: () {
                context.go('/owner/collections');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Billing/Reports'),
              onTap: () {
                context.go('/owner/billing-reports');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                context.go('/settings/profile');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, Owner!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Overview of Orders, Collections, Staff, Farmer connections will go here.'),
            // Add dashboard widgets here
          ],
        ),
      ),
    );
  }
}