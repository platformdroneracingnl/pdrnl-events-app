import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Own package imports
import 'package:pdrnl_events_app/providers/events_provider.dart';
import 'package:pdrnl_events_app/widgets/event/app_bar.dart';
import 'package:pdrnl_events_app/widgets/event/scroll_paper.dart';
import 'package:pdrnl_events_app/widgets/event/signup_button.dart';

class EventDetailtScreen extends StatelessWidget {
  static const routeName = '/event-detail';

  const EventDetailtScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final eventId = ModalRoute.of(context)!.settings.arguments as int;
    final loadedEvent = Provider.of<EventsProvider>(
      context,
      listen: false,
    ).findById(eventId);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            // Event header image
            SizedBox(
              width: double.infinity,
              height: 350,
              child: Image.network(
                  'https://images.pexels.com/photos/2263436/pexels-photo-2263436.jpeg',
                  fit: BoxFit.cover),
            ),
            const EventAppBar(),
            EventScrollPaper(event: loadedEvent),
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
