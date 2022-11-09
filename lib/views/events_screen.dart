import 'package:flutter/material.dart';
import 'package:pdrnl_events_app/widgets/event/event_card.dart';
import 'package:provider/provider.dart';

import 'package:pdrnl_events_app/providers/auth_provider.dart';
import 'package:pdrnl_events_app/providers/events_provider.dart';

class EventsScreen extends StatelessWidget {
  static const routeName = '/events';

  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final eventsProvider = Provider.of<EventsProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: eventsProvider.getEvents(authProvider.token),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Consumer<EventsProvider>(
              builder: (ctx, eventsData, _) => ListView.builder(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: eventsData.visibleEvents.length,
                itemBuilder: (context, index) {
                  final event = eventsData.visibleEvents[index];
                  return EventCard(event: event);
                },
              ),
            );
          }
        }),
      ),
    );
  }
}
