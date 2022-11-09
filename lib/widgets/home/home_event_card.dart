import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

// Own package imports
import 'package:pdrnl_events_app/utils/constants.dart';
import 'package:pdrnl_events_app/models/event.dart';
import 'package:pdrnl_events_app/views/event_detail_screen.dart';
import 'package:pdrnl_events_app/widgets/event/event_card_price.dart';

class HomeEventCard extends StatelessWidget {
  const HomeEventCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      width: 300,
      // color: Colors.red,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Positioned(
            bottom: 0,
            child: Container(
              height: 120,
              width: 290,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 5,
                      ),
                      child: Text(
                        event.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: const Icon(
                            Icons.location_on,
                            size: 10,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          event.location.name,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            right: 5,
                          ),
                          child: const Icon(
                            Icons.calendar_month,
                            size: 10,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          DateFormat('dd-MM-yyyy').format(event.date),
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Event image
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                EventDetailScreen.routeName,
                arguments: event.id,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      height: 180,
                      width: 275,
                      fit: BoxFit.cover,
                      image:
                          NetworkImage('$baseImagesUrl/events/${event.image}'),
                    ),
                  ),
                  // Ticket price
                  EventCardPrice(event: event),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
