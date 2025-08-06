// lib/features/owner/screens/business_management_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_app_bar.dart';
import 'package:poultry_supply_chain_app/common/widgets/loading_indicator.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_text_field.dart'; // You might need to create this
import 'package:poultry_supply_chain_app/common/widgets/custom_button.dart'; // You might need to create this
import 'package:poultry_supply_chain_app/common/widgets/custom_card.dart';
import 'package:poultry_supply_chain_app/features/owner/providers/business_management_provider.dart';
import 'package:poultry_supply_chain_app/common/models/user.dart'; // Import User model

class BusinessManagementScreen extends StatefulWidget {
  const BusinessManagementScreen({super.key});

  @override
  State<BusinessManagementScreen> createState() => _BusinessManagementScreenState();
}

class _BusinessManagementScreenState extends State<BusinessManagementScreen> {
  final _businessNameController = TextEditingController();
  final _businessAddressController = TextEditingController();
  final _businessPhoneController = TextEditingController();
  final _addUserIdController = TextEditingController();
  String? _selectedRoleToAdd; // For dropdown

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BusinessManagementProvider>(context, listen: false).fetchBusinessDetails();
    });
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _businessAddressController.dispose();
    _businessPhoneController.dispose();
    _addUserIdController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  void _updateBusinessDetails() async {
    final provider = Provider.of<BusinessManagementProvider>(context, listen: false);
    await provider.updateBusinessDetails(
      _businessNameController.text,
      _businessAddressController.text,
      _businessPhoneController.text,
    );
    if (provider.errorMessage != null) {
      _showSnackBar(provider.errorMessage!, isError: true);
    } else if (provider.successMessage != null) {
      _showSnackBar(provider.successMessage!);
    }
    provider.clearMessages();
  }

  void _addUser() async {
    if (_addUserIdController.text.isEmpty || _selectedRoleToAdd == null) {
      _showSnackBar('Please enter User ID and select a Role.', isError: true);
      return;
    }
    final provider = Provider.of<BusinessManagementProvider>(context, listen: false);
    await provider.addUser(_addUserIdController.text, _selectedRoleToAdd!);
    if (provider.errorMessage != null) {
      _showSnackBar(provider.errorMessage!, isError: true);
    } else if (provider.successMessage != null) {
      _showSnackBar(provider.successMessage!);
      _addUserIdController.clear();
      setState(() {
        _selectedRoleToAdd = null;
      });
    }
    provider.clearMessages();
  }

  void _removeUser(String userId) async {
    final provider = Provider.of<BusinessManagementProvider>(context, listen: false);
    await provider.removeUser(userId);
    if (provider.errorMessage != null) {
      _showSnackBar(provider.errorMessage!, isError: true);
    } else if (provider.successMessage != null) {
      _showSnackBar(provider.successMessage!);
    }
    provider.clearMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Business Management'),
      body: Consumer<BusinessManagementProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: LoadingIndicator());
          }

          // Initialize text controllers with current business data
          if (provider.currentBusiness != null) {
            _businessNameController.text = provider.currentBusiness!.name;
            _businessAddressController.text = provider.currentBusiness!.address ?? '';
            _businessPhoneController.text = provider.currentBusiness!.contactPhone ?? '';
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Business Details',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  controller: _businessNameController,
                  labelText: 'Business Name',
                  hintText: 'e.g., My Poultry Supply',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _businessAddressController,
                  labelText: 'Address',
                  hintText: 'e.g., 123 Main St, City',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _businessPhoneController,
                  labelText: 'Contact Phone',
                  hintText: 'e.g., +1234567890',
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  icon: Icons.adb,
                  text: 'Update Business Details',
                  onPressed: _updateBusinessDetails,
                  isLoading: provider.isLoading,
                ),
                const Divider(height: 40),
                Text(
                  'Manage Linked Users',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: _addUserIdController,
                        labelText: 'User ID to Add',
                        hintText: 'e.g., user_abc_123',
                      ),
                    ),
                    const SizedBox(width: 10),
                    DropdownButton<String>(
                      value: _selectedRoleToAdd,
                      hint: const Text('Role'),
                      items: const [
                        DropdownMenuItem(value: 'EMPLOYEE', child: Text('Employee')),
                        DropdownMenuItem(value: 'FARMER', child: Text('Farmer')),
                        DropdownMenuItem(value: 'CUSTOMER', child: Text('Customer')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedRoleToAdd = value;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    CustomButton(
                      icon: Icons.add,
                      text: 'Add User',
                      onPressed: _addUser,
                      isLoading: provider.isLoading,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Current Linked Users (${provider.businessUsers.length})',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                if (provider.businessUsers.isEmpty)
                  const Text('No users linked to this business yet.')
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.businessUsers.length,
                    itemBuilder: (context, index) {
                      final user = provider.businessUsers[index];
                      return CustomCard(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(user.name),
                          subtitle: Text('${user.role} - ${user.phone} (ID: ${user.id})'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeUser(user.id),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}