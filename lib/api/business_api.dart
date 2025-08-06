// lib/api/business_api.dart
import 'package:poultry_supply_chain_app/common/services/api_service.dart';
import 'package:poultry_supply_chain_app/common/models/business.dart';
import 'package:poultry_supply_chain_app/common/models/user.dart';
import 'package:poultry_supply_chain_app/common/services/mock_api_service.dart';

class BusinessApi {
  static final MockApiService _apiService = MockApiService();

  Future<Business> getMyBusiness() async {
    // In a real app, the business ID would come from the logged-in owner's data
    // For mocks, we use a placeholder that matches our mock data key
    final response = await _apiService.getRequest('/business/my');
    return Business.fromJson(response);
  }

  Future<List<User>> getBusinessUsers(String businessId) async {
    final response = await _apiService.getRequest('/business/$businessId/users');
    return (response as List).map((json) => User.fromJson(json)).toList();
  }

  Future<Map<String, dynamic>> addUserToBusiness(String businessId, String userId, String role) async {
    return await _apiService.postRequest(
      '/business/$businessId/add-user',
      {'userId': userId, 'role': role},
    );
  }

  Future<Map<String, dynamic>> removeUserFromBusiness(String businessId, String userId) async {
    return await _apiService.deleteRequest('/business/$businessId/remove-user/$userId');
  }

  // Optional: API for creating/updating business details if you want to implement that
  Future<Map<String, dynamic>> updateBusiness(String businessId, Map<String, dynamic> data) async {
    // This would typically be a PATCH or PUT request
    // For now, we'll just mock a success
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network
    return {'success': true, 'message': 'Business updated successfully!'};
  }
}