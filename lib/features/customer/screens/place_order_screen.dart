import 'package:flutter/material.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_app_bar.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_text_field.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_button.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();
  final _addressController = TextEditingController();
  String? _selectedProduct = 'Broiler Chicken';
  DateTime? _selectedDeliveryDate;

  @override
  void dispose() {
    _quantityController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _selectDeliveryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      setState(() => _selectedDeliveryDate = picked);
    }
  }

  void _submitOrder() {
    if (_formKey.currentState!.validate()) {
      // Process order (mock for now)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order placed successfully!')),
      );
      Navigator.pop(context); // Go back to dashboard
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Place New Order'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Selection
              DropdownButtonFormField<String>(
                value: _selectedProduct,
                decoration: const InputDecoration(
                  labelText: 'Product',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Broiler Chicken',
                    child: Text('Broiler Chicken'),
                  ),
                  DropdownMenuItem(
                    value: 'Eggs',
                    child: Text('Eggs (Tray)'),
                  ),
                  DropdownMenuItem(
                    value: 'Processed Meat',
                    child: Text('Processed Meat'),
                  ),
                ],
                onChanged: (value) => setState(() => _selectedProduct = value),
              ),
              const SizedBox(height: 20),

              // Quantity
              CustomTextField(
                controller: _quantityController,
                labelText: 'Quantity',
                hintText: 'e.g., 5 kg',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter quantity';
                  if (double.tryParse(value) == null) return 'Enter a valid number';
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Delivery Address
              CustomTextField(
                controller: _addressController,
                labelText: 'Delivery Address',
                hintText: 'Enter complete address',
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Address is required';
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Delivery Date
              InkWell(
                onTap: () => _selectDeliveryDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Delivery Date',
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDeliveryDate == null
                            ? 'Select Date'
                            : '${_selectedDeliveryDate!.day}/${_selectedDeliveryDate!.month}/${_selectedDeliveryDate!.year}',
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Estimate Price
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Estimated Price', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('₹450', style: TextStyle(fontSize: 18, color: Colors.green)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Place Order Button
              CustomButton(
                icon: Icons.add,
                text: 'Place Order',
                onPressed: _submitOrder,
              ),
            ],
          ),
        ),
      ),
    );
  }
}