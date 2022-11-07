import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:fluentui_icons/fluentui_icons.dart';

// Own package imports
import 'package:pdrnl_events_app/utils/constants.dart';
import 'package:pdrnl_events_app/views/main/dashboard_screen.dart';
import 'package:pdrnl_events_app/views/main/profile_screen.dart';
import 'package:pdrnl_events_app/views/main/search_screen.dart';
import 'package:pdrnl_events_app/views/main/tickets_screen.dart';
import 'package:pdrnl_events_app/views/auth/login_screen.dart';
import 'package:pdrnl_events_app/providers/auth_provider.dart';

class BaseScreen extends StatefulWidget {
  static const routeName = '/home';

  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  List<Widget>? screens = [
    const DashboardScreen(),
    const SearchScreen(),
    const TicketsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home'),
      // ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       ElevatedButton(
      //           onPressed: () {
      //             Provider.of<AuthProvider>(context, listen: false).logout();
      //             Navigator.of(context).pushNamed(LoginScreen.routeName);
      //           },
      //           child: const Text('Logout')),
      //     ],
      //   ),
      // ),
      body: IndexedStack(
        index: _selectedIndex,
        children: screens!,
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
            backgroundColor: Colors.white,
            color: Colors.grey[600],
            activeColor: Colors.white,
            tabBackgroundColor: orangeLightColors,
            padding: const EdgeInsets.all(12),
            onTabChange: (valueIndex) {
              setState(() {
                _selectedIndex = valueIndex;
              });
            },
            gap: 8,
            tabs: const [
              GButton(
                icon: FluentSystemIcons.ic_fluent_home_regular,
                text: 'Home',
              ),
              GButton(
                icon: FluentSystemIcons.ic_fluent_search_regular,
                text: 'Search',
              ),
              GButton(
                icon: FluentSystemIcons.ic_fluent_ticket_regular,
                text: 'Tickets',
              ),
              GButton(
                icon: FluentSystemIcons.ic_fluent_person_regular,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
