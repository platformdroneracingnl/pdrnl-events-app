import 'package:flutter/material.dart';

// Own package imports
import 'package:pdrnl_events_app/widgets/home/events_upcoming.dart';
import 'package:pdrnl_events_app/widgets/home/events_header.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: 75),
          // Events header
          HomeEventsHeader(),
          SizedBox(height: 10),
          UpcomingEvents(),
        ],
      ),
    );
  }
}
