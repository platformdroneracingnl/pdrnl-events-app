import 'package:flutter/material.dart';
import 'package:pdrnl_events_app/widgets/tickets/registration_item.dart';
import 'package:provider/provider.dart';

import 'package:pdrnl_events_app/providers/auth_provider.dart';
import 'package:pdrnl_events_app/providers/registrations_provider.dart';

class LatestRegistrations extends StatelessWidget {
  const LatestRegistrations({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final registrationsProvider =
        Provider.of<RegistrationsProvider>(context, listen: false);

    return FutureBuilder(
        future: registrationsProvider.getRegistrations(authProvider.token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Consumer<RegistrationsProvider>(
              builder: (ctx, registrationsData, _) => ListView.builder(
                padding: const EdgeInsets.only(left: 16, right: 16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: registrationsData.latestRegistrations.length,
                itemBuilder: (context, index) {
                  final registration =
                      registrationsData.latestRegistrations[index];
                  return RegistrationItem(registration: registration);
                },
              ),
            );
          }
        });
  }
}
