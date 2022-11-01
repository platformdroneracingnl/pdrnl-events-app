import 'package:flutter/material.dart';
import 'package:pdrnl_events_app/providers/auth_provider.dart';
import 'package:pdrnl_events_app/views/main/base_screen.dart';
import 'package:pdrnl_events_app/views/auth/login_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: FutureBuilder(
        future: auth.getToken(),
        builder: (ctx, authResultSnapshot) =>
            authResultSnapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : auth.isAuthenticated
                    ? const BaseScreen()
                    : const LoginScreen(),
      ),
    );
  }
}
