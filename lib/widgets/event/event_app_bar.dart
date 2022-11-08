import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pdrnl_events_app/models/event.dart';
import 'package:pdrnl_events_app/utils/constants.dart';

class EventAppBar extends StatelessWidget {
  final Event event;
  const EventAppBar({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {},
        ),
      ],
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      expandedHeight: 310,
      backgroundColor: Colors.black87,
      elevation: 0,
      pinned: false,
      stretch: true,
      centerTitle: true,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.blurBackground,
          StretchMode.zoomBackground,
        ],
        background: Image.network(
          '$baseImagesUrl/events/${event.image}',
          fit: BoxFit.cover,
        ),
      ),
      // bottom: PreferredSize(
      //   preferredSize: const Size.fromHeight(30),
      //   child: Container(
      //     height: 32.0,
      //     alignment: Alignment.center,
      //     decoration: const BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.only(
      //         topLeft: Radius.circular(30.0),
      //         topRight: Radius.circular(30.0),
      //       ),
      //     ),
      //     child: Container(
      //       width: 40.0,
      //       height: 5.0,
      //       decoration: BoxDecoration(
      //         color: Colors.grey[300],
      //         borderRadius: BorderRadius.circular(100.0),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
