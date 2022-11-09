import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:pdrnl_events_app/utils/constants.dart';
import 'package:pdrnl_events_app/models/event.dart';
import 'package:pdrnl_events_app/views/event_detail_screen.dart';
import 'package:pdrnl_events_app/widgets/event/event_card_price.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 15.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: Image.network(
                    '$baseImagesUrl/events/${event.image}',
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                // Ticket price
                EventCardPrice(event: event),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    event.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.star_outline_rounded,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.share,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                bottom: 8.0,
              ),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.calendar_month,
                    color: Colors.grey,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    DateFormat('dd-MM-yyyy').format(event.date),
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.location_on,
                    color: Colors.grey,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    event.location.name,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Styles.primaryColor,
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      EventDetailScreen.routeName,
                      arguments: event.id,
                    );
                  },
                  child: const Text('View Details'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
