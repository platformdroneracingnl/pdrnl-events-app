import 'package:flutter/material.dart';

class EventSignUpButton extends StatelessWidget {
  const EventSignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        width: 280,
        height: 50,
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            foregroundColor: Colors.white,
            backgroundColor: Colors.orange[700],
          ),
          child: const Text(
            'Sign up!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
