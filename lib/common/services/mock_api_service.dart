import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart'; // Import for kDebugMode

class MockApiService {
  // IMPORTANT: Set this to true for UI development without a backend.
  // Set to false when you connect to a real backend.
  static const bool _useMocks = kDebugMode; // Use mocks only in debug mode

  // Only needed if _useMocks is false and you have a real backend URL
  static const String _baseUrl = 'YOUR_API_BASE_URL'; // Replace if you get a real backend later

  // Helper to get the authentication token (still useful for mock auth state)
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  // Helper to set common headers (less critical for mocks, but good practice)
  Future<Map<String, String>> _getHeaders({bool includeAuth = true}) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (includeAuth) {
      final token = await _getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  // --- MOCK DATA DEFINITIONS ---
  // Define mock responses for different endpoints
  static final Map <String, dynamic> _mockResponses = {
    '/auth/login': {
      'OWNER': {'token': 'mock_owner_token', 'user': {'id': '1', 'name': 'Mock Owner', 'phone': '1', 'role': 'OWNER'}},
      'EMPLOYEE': {'token': 'mock_employee_token', 'user': {'id': '2', 'name': 'Mock Employee', 'phone': '2', 'role': 'EMPLOYEE'}},
      'FARMER': {'token': 'mock_farmer_token', 'user': {'id': '3', 'name': 'Mock Farmer', 'phone': '3', 'role': 'FARMER'}},
      'CUSTOMER': {'token': 'mock_customer_token', 'user': {'id': '4', 'name': 'Mock Customer', 'phone': '4', 'role': 'CUSTOMER'}},
    },
    '/auth/register': {'success': true, 'message': 'Registration successful!'},
    '/auth/logout': {'success': true}, // No content usually, but a mock response helps
    '/dashboard/summary/mock_owner_token': { // This endpoint is called by the Owner Dashboard
      'totalOrders': 150,
      'pendingCollections': 5,
      'activeFarmers': 12,
      'revenueToday': 12500.75,
      'totalEmployees': 8,
      'totalCustomers': 55,
    },
    '/business/mock_owner_business_id/users': [ // Mock data for users linked to a business
      // Employees
      {'id': 'emp1', 'name': 'Alice Employee', 'phone': '2222222222', 'role': 'EMPLOYEE'},
      {'id': 'emp2', 'name': 'Bob Employee', 'phone': '2222222223', 'role': 'EMPLOYEE'},
      // Farmers
      {'id': 'farm1', 'name': 'Charlie Farmer', 'phone': '3333333333', 'role': 'FARMER'},
      {'id': 'farm2', 'name': 'Diana Farmer', 'phone': '3333333334', 'role': 'FARMER'},
      // Customers
      {'id': 'cust1', 'name': 'Eve Customer', 'phone': '4444444444', 'role': 'CUSTOMER'},
      {'id': 'cust2', 'name': 'Frank Customer', 'phone': '4444444445', 'role': 'CUSTOMER'},
    ],
    '/business/my': {
      'id': 'mock_owner_business_id',
      'name': 'Owner\'s Poultry Supply Co.',
      'ownerId': '1',
      'address': '123 Chicken Lane, Farmville',
      'contactPhone': '9998887777',
    },
    '/business/mock_owner_business_id/add-user': {'success': true, 'message': 'User added successfully!'},
    '/business/mock_owner_business_id/remove-user/mock_user_id': {'success': true, 'message': 'User removed successfully!'}, // Generic mock for removal

    // Add a mock for getting a single user's profile if needed for adding users by ID
    '/users/mock_user_id_to_add': {
      'id': 'mock_user_id_to_add',
      'name': 'New User',
      'phone': '5555555555',
      'role': 'CUSTOMER', // Or EMPLOYEE/FARMER based on test case
    },
    // Add more specific mocks as you build out each management screen
    // e.g., '/business/my': {'id': 'mock_owner_business_id', 'name': 'Owner\'s Poultry Supply', 'ownerId': '1'},
  };


  // --- MOCK RESPONSE HANDLER ---
  Future<dynamic> _getMockResponse(String endpoint, {Map<String, dynamic>? body}) async {
    print('MOCK API Call: $endpoint');
    await Future.delayed(const Duration(milliseconds: 800)); // Simulate network delay

    if (endpoint == '/auth/login' && body != null) {
      final phone = body['phone'];
      // Simple mock login logic based on phone number
      if (phone == '1') return _mockResponses['/auth/login']!['OWNER'];
      if (phone == '2') return _mockResponses['/auth/login']!['EMPLOYEE'];
      if (phone == '3') return _mockResponses['/auth/login']!['FARMER'];
      if (phone == '4') return _mockResponses['/auth/login']!['CUSTOMER'];
      throw Exception('Mock Login Failed: Invalid credentials');
    }

    if (endpoint == '/auth/register') {
      return _mockResponses['/auth/register'];
    }

    if (endpoint == '/auth/logout') {
      return _mockResponses['/auth/logout'];
    }

    // Generic mock response for other GET requests
    if (_mockResponses.containsKey(endpoint)) {
      return _mockResponses[endpoint];
    }
    if (endpoint.startsWith('/business/') && endpoint.endsWith('/users')) {
      return _mockResponses['/business/mock_owner_business_id/users'];
    }
// Add mock for /business/my if needed for BusinessManagementScreen
    if (endpoint == '/business/my') {
      return _mockResponses['/business/my'];
    }
    if (endpoint == '/business/my') {
      return _mockResponses['/business/my'];
    }
// Add specific mock handling for add-user
    if (endpoint.startsWith('/business/') && endpoint.endsWith('/add-user')) {
      return _mockResponses['/business/mock_owner_business_id/add-user'];
    }
// Add specific mock handling for remove-user
    if (endpoint.startsWith('/business/') && endpoint.contains('/remove-user/')) {
      return _mockResponses['/business/mock_owner_business_id/remove-user/mock_user_id'];
    }
// Add specific mock handling for /users/:id
    if (endpoint.startsWith('/users/')) {
      return _mockResponses['/users/mock_user_id_to_add'];
    }

    // Fallback for unmocked endpoints
    print('WARNING: No mock response defined for $endpoint');
    throw Exception('Mock API: Endpoint not mocked: $endpoint');
  }

  // --- MODIFIED REQUEST METHODS ---
  Future<dynamic> getRequest(String endpoint) async {
    if (_useMocks) {
      return _getMockResponse(endpoint);
    }
    final response = await http.get(Uri.parse('$_baseUrl$endpoint'), headers: await _getHeaders());
    return _handleResponse(response);
  }

  Future<dynamic> postRequest(String endpoint, Map<String, dynamic> body, {bool includeAuth = true}) async {
    if (_useMocks) {
      return _getMockResponse(endpoint, body: body);
    }
    final response = await http.post(Uri.parse('$_baseUrl$endpoint'), headers: await _getHeaders(includeAuth: includeAuth), body: jsonEncode(body));
    return _handleResponse(response);
  }

  Future<dynamic> patchRequest(String endpoint, Map<String, dynamic> body) async {
    if (_useMocks) {
      return _getMockResponse(endpoint, body: body); // You might need more specific mock logic for PATCH
    }
    final response = await http.patch(Uri.parse('$_baseUrl$endpoint'), headers: await _getHeaders(), body: jsonEncode(body));
    return _handleResponse(response);
  }

  Future<dynamic> deleteRequest(String endpoint) async {
    if (_useMocks) {
      return _getMockResponse(endpoint); // You might need more specific mock logic for DELETE
    }
    final response = await http.delete(Uri.parse('$_baseUrl$endpoint'), headers: await _getHeaders());
    return _handleResponse(response);
  }

  // Generic response handler (still used if _useMocks is false)
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isNotEmpty) {
        return json.decode(response.body);
      }
      return {}; // Return empty map for 204 No Content
    } else {
      print('API Error: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to load data: ${response.statusCode} ${response.body}');
    }
  }
}