import 'package:flutter/material.dart';

// Own package imports
import 'package:pdrnl_events_app/utils/color.dart';

class LaunchLoading extends StatelessWidget {
  const LaunchLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [orangeColors, orangeLightColors],
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/pdrnl_white.png", width: 300),
            const SizedBox(height: 100),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
