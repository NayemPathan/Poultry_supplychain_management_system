import 'package:flutter/material.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_card.dart';

class ViewAssignedOrdersScreen extends StatelessWidget {
  const ViewAssignedOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock order data
    final orders = [
      {
        'id': '#CO-5001',
        'customer': 'John Doe',
        'items': 'Broiler Chicken (5kg)',
        'status': 'Assigned',
        'collection_date': 'Today, 10:00 AM',
      },
      {
        'id': '#CO-5002',
        'customer': 'Jane Smith',
        'items': 'Eggs (2 trays)',
        'status': 'Ready for Delivery',
        'collection_date': 'Tomorrow',
      },
    ];

    return Scaffold(
      appBar: CustomAppBar(title: 'Assigned Orders'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return CustomCard(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(order['id']!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order['customer']!),
                  Text(order['items']!),
                  Text(order['collection_date']!),
                ],
              ),
              trailing: Chip(
                label: Text(order['status']!),
                backgroundColor: order['status'] == 'Assigned'
                    ? Colors.orange.withOpacity(0.2)
                    : Colors.green.withOpacity(0.2),
                labelStyle: TextStyle(
                  color: order['status'] == 'Assigned'
                      ? Colors.orange
                      : Colors.green,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}