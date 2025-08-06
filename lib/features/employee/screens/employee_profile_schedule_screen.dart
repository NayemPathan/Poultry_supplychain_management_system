import 'package:flutter/material.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_app_bar.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_card.dart';

class EmployeeProfileScheduleScreen extends StatelessWidget {
  const EmployeeProfileScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile & Schedule'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
            ),
            const SizedBox(height: 16),
            Text(
              'Employee Name',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Employee ID: EMP001',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            CustomCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weekly Schedule',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    _buildScheduleItem(context, 'Monday', '2 Collections', '3 Deliveries'),
                    _buildScheduleItem(context, 'Tuesday', '1 Collection', '5 Deliveries'),
                    _buildScheduleItem(context, 'Wednesday', '3 Collections', '2 Deliveries'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            CustomCard(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Information',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    _buildContactItem(Icons.phone, 'Phone: +1 234 567 8900'),
                    _buildContactItem(Icons.email, 'Email: employee@example.com'),
                    _buildContactItem(Icons.location_on, 'Assigned Region: North District'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleItem(BuildContext context, String day, String collections, String deliveries) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              day,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(collections),
          ),
          Expanded(
            child: Text(deliveries),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}