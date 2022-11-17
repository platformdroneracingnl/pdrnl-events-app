import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Own package import
import 'package:pdrnl_events_app/utils/constants.dart';
import 'package:pdrnl_events_app/views/auth/login_screen.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  _storeOnboardInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isOnboarded', true);
  }

  @override
  Widget build(BuildContext context) {
    PageDecoration pageDecoration = const PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
        ),
        bodyTextStyle: TextStyle(fontSize: 19.0),
        bodyPadding: EdgeInsets.all(16.0));

    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      pages: onboardItems(pageDecoration, context),
      onDone: () {
        _storeOnboardInfo();
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      },
      showSkipButton: true,
      showNextButton: true,
      showDoneButton: true,
      showBackButton: false,
      dotsFlex: 3,
      nextFlex: 1,
      skipOrBackFlex: 1,
      back: Icon(Icons.arrow_back, color: primary),
      skip: Text(
        'Skip',
        style: TextStyle(fontWeight: FontWeight.bold, color: primary),
      ),
      next: Icon(Icons.arrow_forward, color: primary),
      done: Text(
        'Done',
        style: TextStyle(fontWeight: FontWeight.bold, color: primary),
      ),
      dotsDecorator: const DotsDecorator(
        size: Size.square(10.0),
        color: Colors.grey,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
      ),
    );
  }

  List<PageViewModel> onboardItems(
      PageDecoration pageDecoration, BuildContext context) {
    return [
      PageViewModel(
        title: 'Welkom bij PDRNL',
        body:
            'Platform Drone Racing Nederland (PDRNL) is een overkoepelende organisatie voor droneracers opgericht door DronEvents, Total Drone Xperience, Team Multirotor Racing Oss, Dutch Drone Squad en Team Blobfish.',
        image: Image.asset('assets/images/pdrnl_dark_color.png', width: 350),
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: 'Eenvoudig inschrijven voor wedstrijden',
        body:
            'Maak een account aan en schrijf je in voor wedstrijden, inschrijven was nog nooit zo makkelijk.',
        image: Image.asset('assets/images/onboard/user.png'),
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: 'Overzichtelijk beheer voor organisatoren',
        body:
            'Als organisator van een wedstrijd heb je alle inschrijvingen op een rij en bepaal je zelf wanneer een inschrijving is geopend.',
        image: Image.asset('assets/images/onboard/list.png'),
        decoration: pageDecoration,
      ),
      PageViewModel(
        title: 'Digitaal inchecken!',
        body:
            'Geen papieren inschrijvingslijsten meer! Inchecken gaat middels een QR code, die je laat scannen door de organisator.',
        image: Image.asset('assets/images/onboard/check.png'),
        decoration: pageDecoration,
        footer: SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primary),
            onPressed: () {
              _storeOnboardInfo();
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
            child: const Text(
              'Get Started',
              style: TextStyle(fontSize: 17),
            ),
          ),
        ),
      )
    ];
  }
}
