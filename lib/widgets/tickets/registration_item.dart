import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

// Own package imports
import 'package:pdrnl_events_app/utils/constants.dart';
import 'package:pdrnl_events_app/models/registration.dart';

class RegistrationItem extends StatelessWidget {
  const RegistrationItem({
    Key? key,
    required this.registration,
  }) : super(key: key);

  final Registration registration;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        qrCodeDialog(context);
      },
      child: Container(
        height: 90,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding:
            const EdgeInsets.only(left: 24, top: 12, bottom: 12, right: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              spreadRadius: 5,
              offset: const Offset(8.0, 8.0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          '$baseImagesUrl/events/${registration.event.image}'),
                    ),
                  ),
                ),
                const SizedBox(width: 13),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      registration.event.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Text(registration.status)
                  ],
                )
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  DateFormat('dd-MM-yyyy').format(registration.createdAt),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void qrCodeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Event registration QR code',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
            const Text(
              'Let this QR code be scanned at the entrance of the event',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200.0,
              height: 200.0,
              child: QrImage(
                errorStateBuilder: (context, error) => Text(error.toString()),
                data: registration.id,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${registration.id} / ${DateFormat('dd-MM-yyyy').format(registration.event.date)}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
