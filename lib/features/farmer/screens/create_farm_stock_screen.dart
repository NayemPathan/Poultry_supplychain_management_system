import 'package:flutter/material.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_app_bar.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_text_field.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_button.dart';

class CreateFarmStockScreen extends StatefulWidget {
  const CreateFarmStockScreen({super.key});

  @override
  State<CreateFarmStockScreen> createState() => _CreateFarmStockScreenState();
}

class _CreateFarmStockScreenState extends State<CreateFarmStockScreen> {
  final _formKey = GlobalKey<FormState>();
  final _stockNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();

  @override
  void dispose() {
    _stockNameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void _createStock() {
    if (_formKey.currentState!.validate()) {
      // Process creating stock (mock for now)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Farm stock created successfully!')),
      );
      // Clear fields
      _stockNameController.clear();
      _priceController.clear();
      _quantityController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Create Farm Stock'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: _stockNameController,
                labelText: 'Stock Name',
                hintText: 'e.g., Broiler Chicken',
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter stock name';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _priceController,
                labelText: 'Price (per kg)',
                hintText: 'e.g., 150',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter price';
                  if (double.tryParse(value) == null) return 'Enter a valid number';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _quantityController,
                labelText: 'Quantity (kg)',
                hintText: 'e.g., 100',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter quantity';
                  if (double.tryParse(value) == null) return 'Enter a valid number';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                icon: Icons.add,
                text: 'Create Stock',
                onPressed: _createStock,
              ),
            ],
          ),
        ),
      ),
    );
  }
}