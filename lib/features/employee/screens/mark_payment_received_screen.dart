import 'package:flutter/material.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_app_bar.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_card.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_button.dart';

class MarkPaymentReceivedScreen extends StatefulWidget {
  const MarkPaymentReceivedScreen({super.key});

  @override
  State<MarkPaymentReceivedScreen> createState() => _MarkPaymentReceivedScreenState();
}

class _MarkPaymentReceivedScreenState extends State<MarkPaymentReceivedScreen> {
  final List<Map<String, dynamic>> _orders = [
    {
      'id': '#CO-5001',
      'customer': 'John Doe',
      'amount': '₹4500',
      'status': 'DELIVERED',
      'payment_status': 'PENDING',
    },
    {
      'id': '#CO-5002',
      'customer': 'Jane Smith',
      'amount': '₹8000',
      'status': 'DELIVERED',
      'payment_status': 'PARTIAL',
    },
  ];

  // Track loading state for buttons
  List<bool> _isLoading = [false, false];

  void _updatePaymentStatus(int index, String status) {
    setState(() {
      _isLoading[index] = true;
    });

    // Simulate processing delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _orders[index]['payment_status'] = status;
        _isLoading[index] = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment status updated to $status')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Mark Payment Received'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          final order = _orders[index];
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
                      Text('Amount: ${order['amount']}'),
                      Text('Delivery Status: ${order['status']}'),
                      Text(
                        'Payment Status: ${order['payment_status']}',
                        style: TextStyle(
                          color: order['payment_status'] == 'PENDING'
                              ? Colors.orange
                              : order['payment_status'] == 'PARTIAL'
                              ? Colors.blue
                              : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        icon: Icons.check,
                        text: 'Mark Paid',
                        onPressed: () {
                          if (!_isLoading[index]) {
                            _updatePaymentStatus(index, 'PAID');
                          }
                        },
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        isDisabled: _isLoading[index],
                        isLoading: _isLoading[index],
                      ),
                      CustomButton(
                        icon: Icons.star_half,
                        text: 'Mark Partial',
                        onPressed: () {
                          if (!_isLoading[index]) {
                            _updatePaymentStatus(index, 'PARTIAL');
                          }
                        },
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        isDisabled: _isLoading[index],
                        isLoading: _isLoading[index],
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