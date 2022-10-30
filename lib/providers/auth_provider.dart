import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool isAuthenticated = false;
  late String token;

  final String baseUrl = '${dotenv.env['API_URL']}/api/v1';

  // Getter for isAuthenticated
  bool get isAuth {
    return isAuthenticated;
  }

  setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    if (token.isNotEmpty) {
      isAuthenticated = true;
    }
  }

  removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  // Register method
  Future<void> register(
    String name,
    String email,
    String password,
    String passwordConfirm,
    String deviceName,
  ) async {
    String uri = '$baseUrl/register';

    http.Response response = await http.post(
      Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirm,
        'device_name': deviceName,
      }),
    );

    // print(response.body);
    switch (response.statusCode) {
      case 200:
        // Set token in shared preferences
        Map<String, dynamic> data = jsonDecode(response.body);
        token = data['data']['token'];
        await setToken(token);

        // Set isAuthenticated to true
        isAuthenticated = true;
        notifyListeners();
        break;
      case 422:
        final errors = jsonDecode(response.body)['data'];
        throw Exception(errors);
      default:
        throw Exception('Something went wrong');
    }
  }

  // Login method
  Future<void> login(
    String email,
    String password,
    String deviceName,
  ) async {
    String uri = '$baseUrl/login';

    http.Response response = await http.post(
      Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'device_name': deviceName,
      }),
    );

    // print(response.body);
    switch (response.statusCode) {
      case 200:
        // Set token
        Map<String, dynamic> data = jsonDecode(response.body);
        token = data['data']['token'];
        await setToken(token);

        // Set isAuthenticated to true
        isAuthenticated = true;
        notifyListeners();
        break;
      case 401:
        throw Exception('Invalid credentials');
      case 422:
        final errors = jsonDecode(response.body)['data'];
        throw Exception(errors);
      default:
        throw Exception('Something went wrong');
    }
  }

  Future<void> logout() async {
    String uri = '$baseUrl/logout';

    http.Response response = await http.post(
      Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Set isAuthenticated to false
      isAuthenticated = false;

      // Remove token
      await removeToken();
    }
    notifyListeners();
  }
}
