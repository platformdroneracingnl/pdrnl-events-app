import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Own package imports
import 'package:pdrnl_events_app/utils/constants.dart';
import 'package:pdrnl_events_app/models/event.dart';

class EventsProvider extends ChangeNotifier {
  List<LocalEvent> events = [];

  LocalEvent findById(int id) {
    return events.firstWhere((event) => event.id == id);
  }

  Future<void> getEvents(String token) async {
    String uri = '$baseUrl/events';

    http.Response response = await http.get(
      Uri.parse(uri),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Loop through the response body [data] and add each event to the _events list
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<LocalEvent> loadedEvents = [];
      // print(extractedData);
      for (var event in (extractedData)['data']) {
        loadedEvents.add(LocalEvent.fromMap(event));
      }
      events = loadedEvents.reversed.toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load events');
    }
    // print('Number of events: ${events.length}');
  }
}
