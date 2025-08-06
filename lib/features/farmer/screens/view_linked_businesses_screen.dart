import 'package:flutter/material.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_app_bar.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_card.dart';

class ViewLinkedBusinessesScreen extends StatelessWidget {
  const ViewLinkedBusinessesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for linked businesses
    final businesses = [
      {'name': 'Farm Fresh', 'id': '1'},
      {'name': 'Poultry Supply Co.', 'id': '2'},
      {'name': 'Eggcellent Farms', 'id': '3'},
    ];

    return Scaffold(
      appBar: CustomAppBar(title: 'Linked Businesses'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: businesses.length,
        itemBuilder: (context, index) {
          final business = businesses[index];
          return CustomCard(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(business['name']!),
              subtitle: Text('Business ID: ${business['id']}'),
            ),
          );
        },
      ),
    );
  }
}