import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

// Import own files
import 'package:pdrnl_events_app/models/event.dart';

class EventLocationMap extends StatelessWidget {
  const EventLocationMap({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: FlutterMap(
        options: MapOptions(
          interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
          center: LatLng(
            event.location.latitude,
            event.location.longitude,
          ),
          zoom: 10.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(
                  event.location.latitude,
                  event.location.longitude,
                ),
                builder: (ctx) =>
                    const Icon(Icons.location_on, size: 40, color: Colors.blue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
