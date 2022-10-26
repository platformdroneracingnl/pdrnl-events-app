import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Own package imports
import 'package:pdrnl_events_app/services/api.dart';

class Auth with ChangeNotifier {
  bool isAuthenticated = false;
  late String token;
  late ApiService apiService;

  // Getter for isAuthenticated
  bool get isAuth {
    return isAuthenticated;
  }

  Auth() {
    init();
  }

  Future<void> init() async {
    token = await getToken();
    if (token.isNotEmpty) {
      isAuthenticated = true;
    }
    apiService = ApiService(token);
    notifyListeners();
  }

  Future<void> register(
    String name,
    String email,
    String password,
    String passwordConfirm,
    String deviceName,
  ) async {
    token = await apiService.register(
      name,
      email,
      password,
      passwordConfirm,
      deviceName,
    );
    await setToken(token);
    isAuthenticated = true;
    notifyListeners();
  }

  Future<void> login(
    String email,
    String password,
    String deviceName,
  ) async {
    token = await apiService.login(email, password, deviceName);
    await setToken(token);
    isAuthenticated = true;
    notifyListeners();
  }

  Future<void> logout() async {
    // await setToken('');
    await apiService.logout();
    await removeToken();
    isAuthenticated = false;
    notifyListeners();
  }

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
