import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Own package imports
import 'package:pdrnl_events_app/models/user.dart';
import 'package:pdrnl_events_app/utils/constants.dart';

class ProfileProvider with ChangeNotifier {
  late LocalUser user;

  Future<void> getUser(String token) async {
    String uri = '$baseUrl/user';

    http.Response response = await http.get(
      Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> data = jsonDecode(response.body);
        user = LocalUser.fromMap(data['data']);
        notifyListeners();
        break;
      default:
        throw Exception('Failed to load user');
    }
  }
}
