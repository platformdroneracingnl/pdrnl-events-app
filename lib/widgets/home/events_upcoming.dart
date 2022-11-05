import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Own package imports
import 'package:pdrnl_events_app/providers/events_provider.dart';
import 'package:pdrnl_events_app/providers/auth_provider.dart';
import 'package:pdrnl_events_app/models/event.dart';
import 'package:pdrnl_events_app/widgets/event/event_card.dart';

class UpcomingEvents extends StatelessWidget {
  const UpcomingEvents({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provEvents = Provider.of<EventsProvider>(context);
    final auth = Provider.of<AuthProvider>(context);

    return SizedBox(
      height: 285,
      // color: Colors.blue,
      child: FutureBuilder(
        future: provEvents.getEvents(auth.token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: provEvents.events.length,
              itemBuilder: (context, index) {
                LocalEvent event = provEvents.events[index];
                return EventCard(event: event);
              },
            );
          }
        },
      ),
    );
  }
}
