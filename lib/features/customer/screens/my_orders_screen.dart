import 'package:flutter/material.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_app_bar.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_card.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock order data
    final orders = [
      {
        'id': '#PO-1001',
        'product': 'Broiler Chicken',
        'quantity': '5 kg',
        'date': '12 Jun 2023',
        'status': 'Delivered',
        'amount': '₹450',
        'deliveryAddress': '123 Main St, City',
      },
      {
        'id': '#PO-1002',
        'product': 'Eggs (Tray)',
        'quantity': '2 trays',
        'date': '15 Jun 2023',
        'status': 'Processing',
        'amount': '₹800',
        'deliveryAddress': '456 Market Rd, City',
      },
      {
        'id': '#PO-1003',
        'product': 'Processed Meat',
        'quantity': '3 kg',
        'date': '20 Jun 2023',
        'status': 'Pending',
        'amount': '₹1,200',
        'deliveryAddress': '789 Farm Lane, City',
      },
    ];

    return Scaffold(
      appBar: CustomAppBar(title: 'My Orders'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return CustomCard(
            margin: const EdgeInsets.only(bottom: 12),
            child: ExpansionTile(
              title: Text(order['id']!),
              subtitle: Text('${order['date']} • ${order['status']}'),
              trailing: Text(
                order['amount']!,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.green),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildOrderDetail('Product', order['product']!),
                      _buildOrderDetail('Quantity', order['quantity']!),
                      _buildOrderDetail('Delivery Address', order['deliveryAddress']!),
                      if (order['status'] == 'Processing')
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Track Order'),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}