import 'package:flutter/material.dart';

class AuthSubmitButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback submitFn;

  const AuthSubmitButton(this.text, this.isLoading, this.submitFn, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: submitFn,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 40),
              ),
              child: Text(text),
            ),
    );
  }
}
