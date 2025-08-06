import 'package:flutter/material.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_app_bar.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_button.dart';

class PaymentInfoScreen extends StatelessWidget {
  const PaymentInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Payment Information'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Methods',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildPaymentMethod(
              context,
              'Credit/Debit Card',
              '**** **** **** 4242',
              Icons.credit_card,
              Colors.blue,
            ),
            _buildPaymentMethod(
              context,
              'UPI',
              'customer@upi',
              Icons.payment,
              Colors.purple,
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: 'Add New Payment Method',
              onPressed: () {},
              icon: Icons.add,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(BuildContext context, String title, String subtitle, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('Edit Payment Method'),
                    onTap: () {/* TODO */},
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete, color: Colors.red),
                    title: const Text('Remove Payment Method'),
                    onTap: () {/* TODO */},
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}