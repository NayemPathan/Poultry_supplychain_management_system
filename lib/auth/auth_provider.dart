//state management for auth//

import 'package:flutter/material.dart';
import 'package:poultry_supply_chain_app/auth/auth_repository.dart';

enum AuthStatus {
  uninitialized,
  authenticated,
  unauthenticated,
  authenticating,
  registering,
}

class AuthProvider with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  AuthStatus _status = AuthStatus.uninitialized;
  String? _userRole; // To store the role of the logged-in user

  AuthStatus get status => _status;
  String? get userRole => _userRole;

  AuthProvider() {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final token = await _authRepository.getToken();
    if (token != null) {
      _userRole = await _authRepository.getUserRole();
      _status = AuthStatus.authenticated;
    } else {
      _status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  Future<bool> login(String phone, String password) async {
    _status = AuthStatus.authenticating;
    notifyListeners();
    final token = await _authRepository.login(phone, password);
    if (token != null) {
      _userRole = await _authRepository.getUserRole();
      _status = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } else {
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String name, String phone, String password, String address, String role) async {
    _status = AuthStatus.registering;
    notifyListeners();
    final success = await _authRepository.register(name, phone, password, address, role);
    if (success) {
      _status = AuthStatus.unauthenticated; // User needs to login after registration
      notifyListeners();
      return true;
    } else {
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _status = AuthStatus.unauthenticated; // A temporary status if needed
    notifyListeners();
    await _authRepository.logout();
    _userRole = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }
}