import 'package:flutter/widgets.dart';

// Own package imports
import 'package:pdrnl_events_app/views/events_screen.dart';
import 'package:pdrnl_events_app/views/event_detail_screen.dart';
import 'package:pdrnl_events_app/views/main/base_screen.dart';
import 'package:pdrnl_events_app/views/auth/login_screen.dart';
import 'package:pdrnl_events_app/views/auth/register_screen.dart';

final Map<String, WidgetBuilder> routes = {
  BaseScreen.routeName: (ctx) => const BaseScreen(),
  LoginScreen.routeName: (ctx) => const LoginScreen(),
  RegisterScreen.routeName: (ctx) => const RegisterScreen(),
  EventsScreen.routeName: (ctx) => const EventsScreen(),
  EventDetailScreen.routeName: (ctx) => const EventDetailScreen(),
};
