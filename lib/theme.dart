import 'package:flutter/material.dart';
import 'package:pdrnl_events_app/utils/constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Styles.bgColor,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.red,
    ).copyWith(
      secondary: Colors.orange,
    ),
  );
}
