import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

// Own package imports
import 'package:pdrnl_events_app/models/event.dart';
import 'package:pdrnl_events_app/views/event_detail_screen.dart';

class HomeEventCard extends StatelessWidget {
  const HomeEventCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  final LocalEvent event;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290,
      height: 230,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(right: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event header
          Stack(
            children: <Widget>[
              // Event image
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    EventDetailtScreen.routeName,
                    arguments: event.id,
                  );
                },
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://images.pexels.com/photos/1190297/pexels-photo-1190297.jpeg'),
                    ),
                  ),
                ),
              ),
              // Ticket price
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 62,
                  height: 33,
                  decoration: BoxDecoration(
                    color: Colors.orange[400],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Gratis',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            event.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${DateFormat('dd-MM-yyyy').format(event.date)} - ${event.category}',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
