import 'package:flutter/material.dart';

class RotatingAnim extends StatelessWidget {
  const RotatingAnim(
      {Key? key, required this.angleAnimation, required this.child})
      : super(key: key);
  final Animation<double> angleAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      key: key,
      animation: angleAnimation,
      builder: (BuildContext context, Widget? child) {
        return RotationTransition(
          // Transform will be rebuild!
          turns: angleAnimation,
          child: child,
          // child wont be rebuild every time animation changes
        );
      },
      child: child,
    );
  }
}
