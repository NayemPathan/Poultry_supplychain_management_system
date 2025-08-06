//core service//

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String _baseUrl = 'YOUR_API_BASE_URL'; // <<< IMPORTANT: Replace with your actual API base URL

  // Helper to get the authentication token
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  // Helper to set common headers, including authorization
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

  Future<http.Response> get(String endpoint) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final headers = await _getHeaders();
    print('GET Request to: $uri with headers: $headers'); // For debugging
    return http.get(uri, headers: headers);
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body, {bool includeAuth = true}) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final headers = await _getHeaders(includeAuth: includeAuth);
    print('POST Request to: $uri with body: ${jsonEncode(body)} and headers: $headers'); // For debugging
    return http.post(uri, headers: headers, body: jsonEncode(body));
  }

  Future<http.Response> patch(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final headers = await _getHeaders();
    print('PATCH Request to: $uri with body: ${jsonEncode(body)} and headers: $headers'); // For debugging
    return http.patch(uri, headers: headers, body: jsonEncode(body));
  }

  Future<http.Response> delete(String endpoint) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final headers = await _getHeaders();
    print('DELETE Request to: $uri with headers: $headers'); // For debugging
    return http.delete(uri, headers: headers);
  }

  // Generic response handler
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

  // Public methods to be used by repositories
  Future<dynamic> getRequest(String endpoint) async {
    final response = await get(endpoint);
    return _handleResponse(response);
  }

  Future<dynamic> postRequest(String endpoint, Map<String, dynamic> body, {bool includeAuth = true}) async {
    final response = await post(endpoint, body, includeAuth: includeAuth);
    return _handleResponse(response);
  }

  Future<dynamic> patchRequest(String endpoint, Map<String, dynamic> body) async {
    final response = await patch(endpoint, body);
    return _handleResponse(response);
  }

  Future<dynamic> deleteRequest(String endpoint) async {
    final response = await delete(endpoint);
    return _handleResponse(response);
  }
}