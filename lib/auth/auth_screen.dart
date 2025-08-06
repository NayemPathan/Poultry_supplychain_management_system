//login and registration//

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:go_router/go_router.dart"; // For routing
import 'package:poultry_supply_chain_app/auth/auth_provider.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_button.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_text_field.dart';
import 'package:poultry_supply_chain_app/common/widgets/loading_indicator.dart';
import 'package:poultry_supply_chain_app/common/widgets/toast_notification.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool _isLoginMode = true;
  String? _selectedRole; // For registration

  final List<String> _roles = ['FARMER', 'CUSTOMER', 'EMPLOYEE', 'OWNER']; // All possible roles

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _toggleAuthMode() {
    setState(() {
      _isLoginMode = !_isLoginMode;
      // Clear fields when switching modes
      _phoneController.clear();
      _passwordController.clear();
      _nameController.clear();
      _addressController.clear();
      _selectedRole = null;
    });
  }

  Future<void> _authenticate() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();

    //if (phone.isEmpty || password.isEmpty) {    // commenting for debugging
    //  ToastNotification.show(context, 'Please enter phone and password.', type: ToastType.error);
    //  return;
    //}
    if (phone.isEmpty) {
      ToastNotification.show(context, 'Please enter phone and password.', type: ToastType.error);
      return;
    }

    bool success = false;
    if (_isLoginMode) {
      success = await authProvider.login(phone, password);
      if (success) {
        ToastNotification.show(context, 'Login successful!');
        // Redirect based on role after successful login
        final userRole = authProvider.userRole;
        if (userRole != null) {
          context.go('/dashboard/$userRole'); // Example: /dashboard/OWNER

        } else {
          context.go('/dashboard/unknown'); // Fallback
        }
      } else {
        ToastNotification.show(context, 'Login failed. Please check your credentials.', type: ToastType.error);
      }
    } else {
      // Registration mode
      final name = _nameController.text.trim();
      final address = _addressController.text.trim();

      if (name.isEmpty || address.isEmpty || _selectedRole == null) {
        ToastNotification.show(context, 'Please fill all registration fields and select a role.', type: ToastType.error);
        return;
      }

      success = await authProvider.register(name, phone, password, address, _selectedRole!);
      if (success) {
        ToastNotification.show(context, 'Registration successful! Please login.', type: ToastType.success);
        _toggleAuthMode(); // Switch back to login mode
      } else {
        ToastNotification.show(context, 'Registration failed. Please try again.', type: ToastType.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final isLoading = authProvider.status == AuthStatus.authenticating || authProvider.status == AuthStatus.registering;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoginMode ? 'Login' : 'Register'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Placeholder for Logo
              const Icon(Icons.local_shipping, size: 100, color: Colors.blueAccent),
              const SizedBox(height: 30),
              Text(
                _isLoginMode ? 'Welcome Back!' : 'Create Your Account',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 30),
              if (!_isLoginMode) ...[
                CustomTextField(
                  controller: _nameController,
                  labelText: 'Full Name',
                  icon: Icons.person,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _addressController,
                  labelText: 'Address',
                  icon: Icons.location_on,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedRole,
                  decoration: const InputDecoration(
                    labelText: 'Select Role',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  items: _roles.map((String role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRole = newValue;
                    });
                  },
                ),
                const SizedBox(height: 16),
              ],
              CustomTextField(
                controller: _phoneController,
                labelText: 'Phone Number',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                labelText: 'Password',
                icon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 24),
              isLoading
                  ? const LoadingIndicator()
                  : CustomButton(
                icon: Icons.cloud_download,
                text: _isLoginMode ? 'Login' : 'Register',
                onPressed: _authenticate,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _toggleAuthMode,
                child: Text(
                  _isLoginMode ? 'Do not have an account? Register' : 'Already have an account? Login',
                ),
              ),
              if (_isLoginMode)
                TextButton(
                  onPressed: () {
                    // Navigate to Forgot Password page
                    ToastNotification.show(context, 'Forgot Password functionality coming soon!');
                  },
                  child: const Text('Forgot Password?'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}