import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Own package imports
import 'package:pdrnl_events_app/providers/auth_provider.dart';
import 'package:pdrnl_events_app/views/main/base_screen.dart';
import 'package:pdrnl_events_app/views/auth/login_screen.dart';
import 'package:pdrnl_events_app/views/onboard_screen.dart';
import 'package:pdrnl_events_app/widgets/launch_loading.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    late bool isOnboarded;

    // Function to force wating and check auth status
    Future<void> waiting() async {
      await Future.delayed(const Duration(seconds: 1));
      await auth.getToken();
      await auth.checkToken();

      // Check if user is onboarded
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.clear();
      isOnboarded = prefs.getBool('isOnboarded') ?? false;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: waiting(),
        builder: (ctx, authResultSnapshot) {
          if (authResultSnapshot.connectionState == ConnectionState.waiting) {
            return const LaunchLoading();
          } else {
            if (!isOnboarded) {
              return const OnboardScreen();
            } else {
              if (auth.isAuth) {
                return const BaseScreen();
              } else {
                return const LoginScreen();
              }
            }
          }
        },
      ),
    );
  }
}
