import 'package:flutter/material.dart';
import 'package:pdrnl_events_app/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Own package imports
import 'package:pdrnl_events_app/theme.dart';
import 'package:pdrnl_events_app/routes.dart';
import 'package:pdrnl_events_app/views/splash_screen.dart';
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
              ChangeNotifierProvider(create: (ctx) => ProfileProvider()),
            ],
            child: MaterialApp(
              title: 'PDRNL Events App',
              debugShowCheckedModeBanner: true,
              theme: theme(),
              initialRoute: '/',
              home: const SplashScreen(),
              routes: routes,
            ),
          );
        },
      ),
    );
  }
}
