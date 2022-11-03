import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Own package imports
import 'package:pdrnl_events_app/providers/events_provider.dart';
import 'package:pdrnl_events_app/providers/auth_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provEvents = Provider.of<EventsProvider>(context);
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: FutureBuilder(
        future: provEvents.getEvents(auth.token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error != null) {
              return const Center(
                child: Text('An error occurred!'),
              );
            } else {
              return ListView.builder(
                itemCount: provEvents.events.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(provEvents.events[index].name),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
