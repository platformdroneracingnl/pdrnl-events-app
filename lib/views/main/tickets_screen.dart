import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pdrnl_events_app/utils/constants.dart';
import 'package:pdrnl_events_app/providers/auth_provider.dart';
import 'package:pdrnl_events_app/providers/registrations_provider.dart';
import 'package:pdrnl_events_app/widgets/tickets/registration_item.dart';

class TicketsScreen extends StatefulWidget {
  static const String routeName = '/tickets';

  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  late Future _registrationsFuture;

  Future _refreshTickets() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Provider.of<RegistrationsProvider>(context, listen: false)
        .getRegistrations(authProvider.token);
  }

  @override
  void initState() {
    _registrationsFuture = _refreshTickets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tickets'),
        backgroundColor: Styles.primaryColor,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshTickets(),
        child: FutureBuilder(
          future: _registrationsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Consumer<RegistrationsProvider>(
                builder: (ctx, registrationsData, _) => ListView.builder(
                  itemCount: registrationsData.registrations.length,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final registration = registrationsData.registrations[index];
                    return RegistrationItem(registration: registration);
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
