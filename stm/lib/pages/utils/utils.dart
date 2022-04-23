import 'package:flutter/material.dart';

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
