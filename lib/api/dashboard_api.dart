// lib/api/dashboard_api.dart
import 'package:poultry_supply_chain_app/common/services/api_service.dart';

class DashboardApi {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> getOwnerDashboardSummary(String businessId) async {
    // In a real app, businessId would come from the logged-in owner's data
    // For mocks, we use a placeholder that matches our mock data key
    final String mockBusinessId = 'mock_owner_business_id'; // Or pass a dummy ID if your mock logic handles it
    return await _apiService.getRequest('/dashboard/summary/$mockBusinessId');
  }
}