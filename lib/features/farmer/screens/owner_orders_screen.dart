import 'package:flutter/material.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_app_bar.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_card.dart';

class OwnerOrdersScreen extends StatelessWidget {
  const OwnerOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock order data
    final orders = [
      {
        'id': '#PO-3001',
        'product': 'Broiler Chicken',
        'quantity': '50 kg',
        'date': '12 Jun 2023',
        'status': 'Delivered',
        'amount': '₹4500',
      },
      {
        'id': '#PO-3002',
        'product': 'Eggs (Tray)',
        'quantity': '100 trays',
        'date': '15 Jun 2023',
        'status': 'Processing',
        'amount': '₹8000',
      },
    ];

    return Scaffold(
      appBar: CustomAppBar(title: 'Owner Orders'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return CustomCard(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(order['id']!),
              subtitle: Text('${order['date']} • ${order['status']}'),
              trailing: Text(
                order['amount']!,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.green),
              ),
            ),
          );
        },
      ),
    );
  }
}