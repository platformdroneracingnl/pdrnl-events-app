import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Own package imports
import 'package:pdrnl_events_app/providers/auth_provider.dart';
import 'package:pdrnl_events_app/views/main/base_screen.dart';
import 'package:pdrnl_events_app/views/auth/login_screen.dart';
import 'package:pdrnl_events_app/widgets/launch_loading.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    // Function to force wating and check auth status
    Future<void> waiting() async {
      await Future.delayed(const Duration(seconds: 1));
      await auth.getToken();
      await auth.checkToken();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: waiting(),
        builder: (ctx, authResultSnapshot) =>
            authResultSnapshot.connectionState == ConnectionState.waiting
                ? const LaunchLoading()
                : auth.isAuthenticated
                    ? const BaseScreen()
                    : const LoginScreen(),
      ),
    );
  }
}
