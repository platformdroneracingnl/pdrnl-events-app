import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Own package imports
import 'package:pdrnl_events_app/providers/events_provider.dart';
import 'package:pdrnl_events_app/providers/auth_provider.dart';
import 'package:pdrnl_events_app/widgets/home/event_card.dart';
import 'package:pdrnl_events_app/widgets/home/events_header.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provEvents = Provider.of<EventsProvider>(context);
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      // backgroundColor: Colors.grey[300],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 75),
          // Events header
          const HomeEventsHeader(),
          const SizedBox(height: 16),
          // Events list
          SizedBox(
            height: 230,
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
                    padding: const EdgeInsets.only(left: 20, right: 6),
                    itemCount: provEvents.events.length,
                    itemBuilder: (context, index) {
                      return HomeEventCard(event: provEvents.events[index]);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
