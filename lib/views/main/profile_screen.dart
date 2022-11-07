import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// My package imports
import 'package:pdrnl_events_app/views/auth/login_screen.dart';
import 'package:pdrnl_events_app/providers/auth_provider.dart';
import 'package:pdrnl_events_app/widgets/profile/profile_header.dart';
import 'package:pdrnl_events_app/widgets/profile/profile_list_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // When a user will logout
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      child: const Text("Uitloggen"),
      onPressed: () {
        Provider.of<AuthProvider>(context, listen: false).logout();
        Navigator.of(context).pushNamed(LoginScreen.routeName);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Are you sure?"),
      content: const Text("Weet je heel zeker dat je wil uitloggen?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          const ProfileHeader(),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: <Widget>[
                ProfileListItem(
                  menuText: 'My Account',
                  menuIcon: Icons.person_outline_rounded,
                  press: () {},
                ),
                ProfileListItem(
                  menuText: 'Notifications',
                  menuIcon: Icons.notifications_none_outlined,
                  press: () {},
                ),
                ProfileListItem(
                  menuText: 'Settings',
                  menuIcon: Icons.settings,
                  press: () {},
                ),
                ProfileListItem(
                  menuText: 'Help Center',
                  menuIcon: Icons.help_outline_outlined,
                  press: () {},
                ),
                ProfileListItem(
                  menuText: 'Uitloggen',
                  menuIcon: Icons.logout_outlined,
                  hasNavigation: false,
                  press: () {
                    showAlertDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
