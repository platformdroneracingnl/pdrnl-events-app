import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Own package imports
import 'package:pdrnl_events_app/utils/constants.dart';
import 'package:pdrnl_events_app/models/registration.dart';

class RegistrationsProvider extends ChangeNotifier {
  List<Registration> registrations = [];

  Registration findById(int id) {
    return registrations.firstWhere((registration) => registration.id == id);
  }

  List<Registration> get latestRegistrations {
    return registrations.toList().take(3).toList();
  }

  Future<void> getRegistrations(String token) async {
    String uri = '$baseUrl/registrations';

    http.Response response = await http.get(
      Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Registration> loadedRegistrations = [];
      for (var registration in (extractedData)['data']) {
        loadedRegistrations.add(Registration.fromMap(registration));
      }
      registrations = loadedRegistrations.reversed.toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load your registrations');
    }
  }
}
