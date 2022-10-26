import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Own package imports
import 'package:pdrnl_events_app/views/login_screen.dart';
import 'package:pdrnl_events_app/providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Provider.of<Auth>(context, listen: false).logout();
                  Navigator.of(context).pushNamed(LoginScreen.routeName);
                },
                child: const Text('Logout')),
          ],
        ),
      ),
    );
  }
}
