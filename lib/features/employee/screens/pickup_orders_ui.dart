import 'package:flutter/material.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_app_bar.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_card.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_button.dart';

class PickupOrdersUI extends StatefulWidget {
  const PickupOrdersUI({super.key});

  @override
  State<PickupOrdersUI> createState() => _PickupOrdersUIState();
}

class _PickupOrdersUIState extends State<PickupOrdersUI> {
  final List<Map<String, dynamic>> _pickupOrders = [
    {
      'id': '#CO-5001',
      'customer': 'John Doe',
      'items': 'Broiler Chicken (5kg)',
      'farm': 'Green Fields Farm',
      'status': 'NOT_STARTED',
    },
    {
      'id': '#CO-5002',
      'customer': 'Jane Smith',
      'items': 'Eggs (2 trays)',
      'farm': 'Morning Fresh Farm',
      'status': 'IN_PROGRESS',
    },
  ];

  void _updateStatus(int index, String status) {
    setState(() {
      _pickupOrders[index]['status'] = status;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Status updated to $status')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Pickup Orders'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _pickupOrders.length,
        itemBuilder: (context, index) {
          final order = _pickupOrders[index];
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
                      Text('Farm: ${order['farm']}'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        icon: Icons.paste,
                        text: 'Start Pickup',
                        onPressed: () => _updateStatus(index, 'START_PICKING'),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        isDisabled: order['status'] != 'NOT_STARTED',
                      ),
                      CustomButton(
                        icon: Icons.pin_end,
                        text: 'Complete Pickup',
                        onPressed: () => _updateStatus(index, 'END_PICKING'),
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