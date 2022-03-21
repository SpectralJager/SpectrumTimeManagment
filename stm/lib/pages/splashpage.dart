import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff234C70),
      body: Center(
        child: RiveAnimation.asset('assets/thats-no-moon.riv'),
      ),
    );
  }
}
