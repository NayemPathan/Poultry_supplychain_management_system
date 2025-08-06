// lib/features/owner/providers/business_management_provider.dart
import 'package:flutter/material.dart';
import 'package:poultry_supply_chain_app/api/business_api.dart';
import 'package:poultry_supply_chain_app/common/models/business.dart';
import 'package:poultry_supply_chain_app/common/models/user.dart';

class BusinessManagementProvider with ChangeNotifier {
  final BusinessApi _businessApi = BusinessApi();

  Business? _currentBusiness;
  List<User> _businessUsers = [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  Business? get currentBusiness => _currentBusiness;
  List<User> get businessUsers => _businessUsers;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  // For simplicity, we'll use a hardcoded business ID for mocks.
  // In a real app, this would come from AuthProvider.currentUser.businessId
  final String _mockBusinessId = 'mock_owner_business_id';

  Future<void> fetchBusinessDetails() async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      _currentBusiness = await _businessApi.getMyBusiness();
      await fetchBusinessUsers(); // Also fetch users when business details are loaded
    } catch (e) {
      _errorMessage = e.toString();
      print('Error fetching business details: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchBusinessUsers() async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      _businessUsers = await _businessApi.getBusinessUsers(_mockBusinessId);
    } catch (e) {
      _errorMessage = e.toString();
      print('Error fetching business users: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addUser(String userId, String role) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      final response = await _businessApi.addUserToBusiness(_mockBusinessId, userId, role);
      if (response['success'] == true) {
        _successMessage = response['message'];
        await fetchBusinessUsers(); // Refresh user list
      } else {
        _errorMessage = response['message'] ?? 'Failed to add user.';
      }
    } catch (e) {
      _errorMessage = e.toString();
      print('Error adding user: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> removeUser(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      final response = await _businessApi.removeUserFromBusiness(_mockBusinessId, userId);
      if (response['success'] == true) {
        _successMessage = response['message'];
        await fetchBusinessUsers(); // Refresh user list
      } else {
        _errorMessage = response['message'] ?? 'Failed to remove user.';
      }
    } catch (e) {
      _errorMessage = e.toString();
      print('Error removing user: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateBusinessDetails(String name, String address, String contactPhone) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      final response = await _businessApi.updateBusiness(
        _mockBusinessId,
        {'name': name, 'address': address, 'contactPhone': contactPhone},
      );
      if (response['success'] == true) {
        _successMessage = response['message'];
        // Update local business object
        _currentBusiness = Business(
          id: _mockBusinessId,
          name: name,
          ownerId: _currentBusiness!.ownerId, // Keep existing ownerId
          address: address,
          contactPhone: contactPhone,
        );
      } else {
        _errorMessage = response['message'] ?? 'Failed to update business details.';
      }
    } catch (e) {
      _errorMessage = e.toString();
      print('Error updating business details: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }
}