import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Own package imports
import 'package:pdrnl_events_app/providers/events_provider.dart';
import 'package:pdrnl_events_app/providers/auth_provider.dart';
import 'package:pdrnl_events_app/widgets/event/event_card.dart';

class UpcomingEvents extends StatelessWidget {
  const UpcomingEvents({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final eventsProvider = Provider.of<EventsProvider>(context, listen: false);

    return SizedBox(
      height: 285,
      child: FutureBuilder(
        future: eventsProvider.getEvents(authProvider.token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Consumer<EventsProvider>(
              builder: (ctx, eventsData, _) => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: eventsData.visibleEvents.length,
                itemBuilder: (context, index) {
                  return EventCard(event: eventsData.visibleEvents[index]);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
