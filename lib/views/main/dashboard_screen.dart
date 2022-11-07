import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Own package imports
import 'package:pdrnl_events_app/providers/auth_provider.dart';
import 'package:pdrnl_events_app/providers/events_provider.dart';
import 'package:pdrnl_events_app/widgets/home/events_header.dart';
import 'package:pdrnl_events_app/widgets/home/events_upcoming.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Future<void> _refreshHome(BuildContext context) async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    await Provider.of<EventsProvider>(context, listen: false)
        .getEvents(auth.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      body: RefreshIndicator(
        onRefresh: () => _refreshHome(context),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                // Events header
                const HomeEventsHeader(),
                const SizedBox(height: 10),
                UpcomingEvents(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
