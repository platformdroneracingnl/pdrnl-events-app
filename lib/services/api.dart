import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  late String token;

  ApiService(this.token);

  final String baseUrl = '${dotenv.env['API_URL']}/api/v1';

  Future<String> register(
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

    // Validation errors
    if (response.statusCode == 422) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Map<String, dynamic> errors = body['data'];
      throw Exception(errors.values.first[0]);
    }

    // Return unauthorised
    if (response.statusCode == 401) {
      throw Exception('Invalid credentials');
    }

    // Return token
    Map<String, dynamic> body = jsonDecode(response.body);
    print(body);
    return body['data']['token'];
  }

  Future<String> login(
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

    // Validation errors
    if (response.statusCode == 422) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Map<String, dynamic> errors = body['data'];
      throw Exception(errors.values.first[0]);
    }

    // Return unauthorised
    if (response.statusCode == 401) {
      throw Exception('Invalid credentials');
    }

    // Return token
    Map<String, dynamic> body = jsonDecode(response.body);
    return body['data']['token'];
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

    // Return unauthorised
    if (response.statusCode == 401) {
      throw Exception('Invalid credentials');
    }
  }
}
