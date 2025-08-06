//authentication logic//

import 'package:poultry_supply_chain_app/common/services/mock_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final MockApiService _apiService = MockApiService();

  Future<String?> login(String phone, String password) async {
    try {
      final response = await _apiService.postRequest(
        '/auth/login',
        {'phone': phone, 'password': password},
        includeAuth: false, // Login doesn't require a token
      );
      // Assuming the API returns a token directly or within a 'token' field
      final String? token = response['token'];
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);
        // Optionally store user role or other profile info
        await prefs.setString('userRole', response['user']['role']);
        return token;
      }
      return null;
    } catch (e) {
      print('Login failed: $e');
      return null;
    }
  }

  Future<bool> register(String name, String phone, String password, String address, String role) async {
    try {
      final response = await _apiService.postRequest(
        '/auth/register',
        {
          'name': name,
          'phone': phone,
          'password': password,
          'address': address,
          'role': role,
        },
        includeAuth: false, // Registration doesn't require a token
      );
      // Assuming successful registration returns a success indicator
      return response != null;
    } catch (e) {
      print('Registration failed: $e');
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _apiService.postRequest('/auth/logout', {}); // Assuming logout API exists
    } catch (e) {
      print('Logout API call failed (might be already logged out): $e');
    } finally {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('authToken');
      await prefs.remove('userRole');
      // Clear any other stored user data
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userRole');
  }
}