import 'package:flutter/material.dart';

// Own package imports
import 'package:pdrnl_events_app/utils/constants.dart';

class HomeSearch extends StatelessWidget {
  const HomeSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6FD),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      child: Row(
        children: [
          const Icon(Icons.search),
          Text('Zoeken', style: Styles.headLineStyle4),
        ],
      ),
    );
  }
}
