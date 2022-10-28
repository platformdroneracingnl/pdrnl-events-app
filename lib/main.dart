import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Own package imports
import 'package:pdrnl_events_app/views/home_screen.dart';
import 'package:pdrnl_events_app/views/login_screen.dart';
import 'package:pdrnl_events_app/views/register_screen.dart';
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
        builder: (ctx, auth, child) => MaterialApp(
          title: 'PDRNL Events App',
          debugShowCheckedModeBanner: true,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.red,
            ).copyWith(
              secondary: Colors.orange,
            ),
          ),
          home: auth.isAuth ? const HomeScreen() : const LoginScreen(),
          routes: {
            HomeScreen.routeName: (ctx) => const HomeScreen(),
            LoginScreen.routeName: (ctx) => const LoginScreen(),
            RegisterScreen.routeName: (ctx) => const RegisterScreen(),
          },
        ),
      ),
    );
  }
}
