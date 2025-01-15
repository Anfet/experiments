import 'package:flutter/material.dart';
import 'package:flutter_commons/flutter_commons.dart';

class AnimatedFlip extends StatefulWidget {
  final Duration duration;
  final Widget child;
  final Color backgroundColor;

  const AnimatedFlip({
    super.key,
    required this.child,
    required this.backgroundColor,
    required this.duration,
  });

  @override
  State<AnimatedFlip> createState() => _AnimatedFlipState();
}

class _AnimatedFlipState extends State<AnimatedFlip> with SingleTickerProviderStateMixin, Logging {
  late final animationController = AnimationController(vsync: this, duration: widget.duration);
  late final Animation<double> tween;

  late Widget _drawingChild;
  bool requiredChange = false;

  @override
  void initState() {
    _drawingChild = widget.child;
    tween = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 90), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 270, end: 360), weight: 50),
    ]).animate(animationController);

    animationController.addListener(() {
      if (requiredChange && animationController.value > .5) {
        _drawingChild = widget.child;
        requiredChange = false;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedFlip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child &&
        animationController.status != AnimationStatus.forward &&
        animationController.status != AnimationStatus.reverse) {
      requiredChange = true;
      animationController.reset();
      animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..rotateY(-tween.value.asRadians)
            // ..rotateX(15.0.asRadians)
            ..setEntry(3, 2, 1.003),
          alignment: FractionalOffset.center,
          child: _drawingChild,
        );
      },
    );
  }
}
