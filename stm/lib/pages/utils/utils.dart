import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

class bgWidget extends StatelessWidget {
  final String bgImage;
  final Color? overlayColor;
  final Widget child;
  const bgWidget({
    required this.bgImage,
    required this.child,
    this.overlayColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage),
            fit: BoxFit.fill,
          ),
          color: Colors.black,
        ),
        child: Container(
          height: size.height,
          width: size.width,
          color: overlayColor,
          child: child,
        ),
      ),
    );
  }
}

class NothingWidget extends StatelessWidget {
  const NothingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.size.width,
          height: Get.size.width,
          child: RiveAnimation.asset('assets/animations/nothing.riv'),
        ),
        Text(
          'Nothing...',
          style: GoogleFonts.oswald(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 4,
          ),
        ),
      ],
    );
  }
}

class multiFABs extends StatelessWidget {
  const multiFABs({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: this.children,
      ),
    );
  }
}

class Label extends StatelessWidget {
  const Label({
    required this.text,
    Key? key,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.oswald(fontSize: 24, color: Colors.white),
      textAlign: TextAlign.left,
    );
  }
}
