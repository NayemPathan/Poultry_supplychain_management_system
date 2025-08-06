// lib/features/owner/providers/owner_dashboard_provider.dart
import 'package:flutter/material.dart';
import 'package:poultry_supply_chain_app/api/dashboard_api.dart'; // Import the API service

class OwnerDashboardProvider with ChangeNotifier {
  final DashboardApi _dashboardApi = DashboardApi();

  Map<String, dynamic>? _dashboardSummary;
  bool _isLoading = false;
  String? _errorMessage;

  Map<String, dynamic>? get dashboardSummary => _dashboardSummary;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchDashboardSummary() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // In a real app, you'd get the businessId from the logged-in user's data
      // For now, we're using a placeholder that matches our mock data
      _dashboardSummary = await _dashboardApi.getOwnerDashboardSummary('mock_owner_business_id');
    } catch (e) {
      _errorMessage = e.toString();
      print('Error fetching owner dashboard summary: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}