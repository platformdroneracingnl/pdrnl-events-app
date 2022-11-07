import 'package:flutter/material.dart';

// Import own files
import 'package:pdrnl_events_app/utils/constants.dart';

class AuthHeader extends StatelessWidget {
  final String text;

  const AuthHeader(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [orangeColors, Styles.primaryColor],
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
          ),
          borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(100))),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 20,
            right: 20,
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          Center(
            child: Image.asset("assets/images/pdrnl_white.png", width: 250),
          ),
        ],
      ),
    );
  }
}
