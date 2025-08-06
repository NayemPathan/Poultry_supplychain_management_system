import 'package:flutter/material.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_app_bar.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_card.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_button.dart';

class DeliveryOrdersUI extends StatefulWidget {
  const DeliveryOrdersUI({super.key});

  @override
  State<DeliveryOrdersUI> createState() => _DeliveryOrdersUIState();
}

class _DeliveryOrdersUIState extends State<DeliveryOrdersUI> {
  final List<Map<String, dynamic>> _deliveryOrders = [
    {
      'id': '#CO-5001',
      'customer': 'John Doe',
      'items': 'Broiler Chicken (5kg)',
      'address': '123 Main St, City',
      'status': 'PENDING',
    },
    {
      'id': '#CO-5002',
      'customer': 'Jane Smith',
      'items': 'Eggs (2 trays)',
      'address': '456 Oak Ave, Town',
      'status': 'IN_PROGRESS',
    },
  ];

  void _updateStatus(int index, String status) {
    setState(() {
      _deliveryOrders[index]['status'] = status;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Status updated to $status')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Delivery Orders'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _deliveryOrders.length,
        itemBuilder: (context, index) {
          final order = _deliveryOrders[index];
          return CustomCard(
            margin: const EdgeInsets.only(bottom: 12),
            child: Column(
              children: [
                ListTile(
                  title: Text(order['id']!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(order['customer']!),
                      Text(order['items']!),
                      Text(order['address']!),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        icon: Icons.start,
                        text: 'Start Delivery',
                        onPressed: () => _updateStatus(index, 'START_DELIVERY'),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        isDisabled: order['status'] != 'PENDING',
                      ),
                      CustomButton(
                        icon: Icons.pin_end_rounded,
                        text: 'Complete Delivery',
                        onPressed: () => _updateStatus(index, 'END_DELIVERY'),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        isDisabled: order['status'] != 'IN_PROGRESS',
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
}