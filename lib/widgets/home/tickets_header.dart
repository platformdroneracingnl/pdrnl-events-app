import 'package:flutter/material.dart';

// Own package imports
import 'package:pdrnl_events_app/utils/constants.dart';

class HomeRegistrationsHeader extends StatefulWidget {
  const HomeRegistrationsHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeRegistrationsHeader> createState() =>
      _HomeRegistrationsHeaderState();
}

class _HomeRegistrationsHeaderState extends State<HomeRegistrationsHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Your latest registrations',
            style: Styles.headLineStyle2,
          ),
          // InkWell(
          //   onTap: () {
          //   },
          //   child: Text(
          //     'View all',
          //     style: Styles.textStyle.copyWith(color: Styles.primaryColor),
          //   ),
          // ),
        ],
      ),
    );
  }
}
