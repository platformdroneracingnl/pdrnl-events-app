import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Own package imports
import 'package:pdrnl_events_app/models/event.dart';

class EventsProvider extends ChangeNotifier {
  List<LocalEvent> events = [];

  final String baseUrl = '${dotenv.env['API_URL']}/api/v1';

  Future<void> getEvents(String token) async {
    final List<LocalEvent> loadedEvents = [];
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
      for (var event in (extractedData)['data']) {
        loadedEvents.add(LocalEvent.fromMap(event));
      }
      events = loadedEvents;
    } else {
      throw Exception('Failed to load events');
    }
    // print('Number of events: ${events.length}');
  }
}
