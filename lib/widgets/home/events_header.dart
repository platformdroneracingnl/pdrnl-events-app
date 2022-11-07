import 'package:flutter/material.dart';

// Own package imports
import 'package:pdrnl_events_app/utils/constants.dart';
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
          Text(
            'Upcoming events',
            style: Styles.headLineStyle2,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, EventsScreen.routeName);
            },
            child: Text(
              'View all',
              style: Styles.textStyle.copyWith(color: Styles.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
