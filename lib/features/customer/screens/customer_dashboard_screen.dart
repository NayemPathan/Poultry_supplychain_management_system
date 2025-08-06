import 'package:flutter/material.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_card.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:poultry_supply_chain_app/auth/auth_provider.dart';


class CustomerDashboardScreen extends StatelessWidget {
  const CustomerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Dashboard'),
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
                'Customer Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add_shopping_cart),
              title: const Text('Place Order'),
              onTap: () {
                context.go('/customer/place-order');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('My Orders'),
              onTap: () {
                context.go('/customer/my-orders');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Payment Info'),
              onTap: () {
                context.go('/customer/payment-info');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Message
            Consumer<AuthProvider>(
              builder: (context, authProvider, _) {
                return Text(
                  'Welcome',
                  style: Theme.of(context).textTheme.headlineSmall,
                );
              },
            ),
            const SizedBox(height: 20),

            // Quick Stats Cards
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                // Active Orders
                CustomCard(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.shopping_basket, size: 40, color: Colors.blue),
                      const SizedBox(height: 8),
                      Text(
                        '3', // Mock data
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.blue),
                      ),
                      const Text('Active Orders'),
                    ],
                  ),
                ),

                // Total Spent
                CustomCard(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.currency_rupee, size: 40, color: Colors.green),
                      const SizedBox(height: 8),
                      Text(
                        '₹1,250', // Mock data
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.green),
                      ),
                      const Text('Total Spent'),
                    ],
                  ),
                ),
              ],
            ),
            // Recent Orders
          ],
        ),
      ),
    );
  }
}

