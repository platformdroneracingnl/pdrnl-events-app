import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Own package imports
import 'package:pdrnl_events_app/utils/constants.dart';
import 'package:pdrnl_events_app/providers/auth_provider.dart';
import 'package:pdrnl_events_app/providers/events_provider.dart';
import 'package:pdrnl_events_app/providers/profile_provider.dart';
import 'package:pdrnl_events_app/providers/registrations_provider.dart';
import 'package:pdrnl_events_app/widgets/home/search.dart';
import 'package:pdrnl_events_app/widgets/home/events_header.dart';
import 'package:pdrnl_events_app/widgets/home/events_upcoming.dart';
import 'package:pdrnl_events_app/widgets/home/latest_registrations.dart';
import 'package:pdrnl_events_app/widgets/home/tickets_header.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/dashboard';

  const DashboardScreen({super.key});

  Future<void> _refreshHome(BuildContext context) async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    await Provider.of<EventsProvider>(context, listen: false)
        .getEvents(auth.token);
    await Provider.of<ProfileProvider>(context, listen: false)
        .getUser(auth.token);
    await Provider.of<RegistrationsProvider>(context, listen: false)
        .getRegistrations(auth.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: RefreshIndicator(
        onRefresh: () => _refreshHome(context),
        child: ListView(
          children: <Widget>[
            // Dashbaord Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Image.asset('assets/images/pdrnl_dark_color.png', height: 45),
                  const SizedBox(height: 5),
                  Text("Ready..Set...GO!", style: Styles.headLineStyle3),
                  // Events header
                ],
              ),
            ),
            const SizedBox(height: 25),
            HomeSearch(),
            const SizedBox(height: 40),
            HomeEventsHeader(),
            const SizedBox(height: 10),
            UpcomingEvents(),
            const SizedBox(height: 25),
            HomeRegistrationsHeader(),
            const SizedBox(height: 10),
            LatestRegistrations(),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
