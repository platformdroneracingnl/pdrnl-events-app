import 'package:flutter/widgets.dart';

// Own package imports
import 'package:pdrnl_events_app/views/events_screen.dart';
import 'package:pdrnl_events_app/views/event_detail_screen.dart';
import 'package:pdrnl_events_app/views/main/base_screen.dart';
import 'package:pdrnl_events_app/views/auth/login_screen.dart';
import 'package:pdrnl_events_app/views/auth/register_screen.dart';
import 'package:pdrnl_events_app/views/main/tickets_screen.dart';

final Map<String, WidgetBuilder> routes = {
  BaseScreen.routeName: (ctx) => const BaseScreen(),
  LoginScreen.routeName: (ctx) => const LoginScreen(),
  RegisterScreen.routeName: (ctx) => const RegisterScreen(),
  TicketsScreen.routeName: (ctx) => const TicketsScreen(),
  EventsScreen.routeName: (ctx) => const EventsScreen(),
  EventDetailScreen.routeName: (ctx) => const EventDetailScreen(),
};
