import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Own package imports
import 'package:pdrnl_events_app/views/splash_screen.dart';
import 'package:pdrnl_events_app/views/events_screen.dart';
import 'package:pdrnl_events_app/views/event_detail_screen.dart';
import 'package:pdrnl_events_app/views/main/base_screen.dart';
import 'package:pdrnl_events_app/views/auth/login_screen.dart';
import 'package:pdrnl_events_app/views/auth/register_screen.dart';
import 'package:pdrnl_events_app/providers/events_provider.dart';
import 'package:pdrnl_events_app/providers/auth_provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (ctx) => EventsProvider()),
              ChangeNotifierProvider(create: (ctx) => AuthProvider()),
            ],
            child: MaterialApp(
              title: 'PDRNL Events App',
              debugShowCheckedModeBanner: true,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: Colors.red,
                ).copyWith(
                  secondary: Colors.orange,
                ),
              ),
              initialRoute: '/',
              home: const SplashScreen(),
              routes: {
                BaseScreen.routeName: (ctx) => const BaseScreen(),
                LoginScreen.routeName: (ctx) => const LoginScreen(),
                RegisterScreen.routeName: (ctx) => const RegisterScreen(),
                EventsScreen.routeName: (ctx) => const EventsScreen(),
                EventDetailtScreen.routeName: (ctx) =>
                    const EventDetailtScreen(),
              },
            ),
          );
        },
      ),
    );
  }
}
