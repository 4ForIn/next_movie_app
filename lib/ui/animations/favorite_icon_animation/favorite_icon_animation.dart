import 'package:flutter/material.dart';
import 'package:next_movie_app/ui/animations/favorite_icon_animation/rotating_anim.dart';

class FavoriteIconAnim extends StatefulWidget {
  const FavoriteIconAnim(
      {Key? key,
      required this.icon,
      required this.isItemFavorite,
      required this.handleIsFavState})
      : super(key: key);
  final Icon icon;
  final bool isItemFavorite;
  final Function handleIsFavState;

  @override
  _FavoriteIconAnimState createState() => _FavoriteIconAnimState();
}

class _FavoriteIconAnimState extends State<FavoriteIconAnim>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationCtrl;
  late Animation<double> _curve;
  late Animation<double> _sizeAnimation;
  late Animation<double> _angleAnimation;

  @override
  void initState() {
    _animationCtrl = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _curve = CurvedAnimation(parent: _animationCtrl, curve: Curves.slowMiddle);
    _sizeAnimation = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 20, end: 30), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 30, end: 20), weight: 50),
    ]).animate(_curve);
    _angleAnimation = Tween<double>(begin: 0, end: 0.6).animate(_animationCtrl);

    super.initState();
  }

  void _handleOnPressed() {
    if (widget.isItemFavorite) {
      _animationCtrl.reverse();
    } else {
      _animationCtrl.forward(from: 0);
    }
    widget.handleIsFavState();
  }

  @override
  void dispose() {
    _animationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationCtrl,
      builder: (BuildContext context, Widget? child) {
        return RotatingAnim(
          angleAnimation: _angleAnimation,
          child: IconButton(
            iconSize: _sizeAnimation.value,
            onPressed: () => _handleOnPressed(),
            icon: child!,
          ),
        );
      },
      child: widget.icon,
    );
  }
}
