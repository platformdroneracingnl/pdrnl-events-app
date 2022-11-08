import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Own package imports
import 'package:pdrnl_events_app/providers/events_provider.dart';
import 'package:pdrnl_events_app/widgets/event/event_app_bar.dart';
import 'package:pdrnl_events_app/widgets/event/event_scroll_paper.dart';
import 'package:pdrnl_events_app/widgets/event/signup_button.dart';

class EventDetailScreen extends StatelessWidget {
  static const routeName = '/event-detail';

  const EventDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final eventId = ModalRoute.of(context)!.settings.arguments as int;
    final loadedEvent = Provider.of<EventsProvider>(
      context,
      listen: false,
    ).findById(eventId);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            CustomScrollView(
              slivers: <Widget>[
                EventAppBar(event: loadedEvent),
                EventScrollPaper(event: loadedEvent),
              ],
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: EventSignUpButton(),
            )
          ],
        ),
      ),
    );
  }
}
