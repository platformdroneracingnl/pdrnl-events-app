import 'package:flutter/material.dart';

// Own package imports
import 'package:pdrnl_events_app/views/events_screen.dart';

class HomeEventsHeader extends StatelessWidget {
  const HomeEventsHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Upcoming events',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, EventsScreen.routeName);
            },
            child: const Text('View all'),
          ),
        ],
      ),
    );
  }
}
