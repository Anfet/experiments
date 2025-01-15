import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_commons/flutter_commons.dart';

class TwoDimensionalScrollScreen extends StatefulWidget {
  const TwoDimensionalScrollScreen({Key? key}) : super(key: key);

  @override
  State<TwoDimensionalScrollScreen> createState() => _TwoDimensionalScrollScreenState();
}

final int amountX = 20;
final int amountY = 20;
final double plateSize = 200;

class _TwoDimensionalScrollScreenState extends State<TwoDimensionalScrollScreen> with TickerProviderStateMixin, Logging {
  final ValueNotifier<Offset> scrollNotifier = ValueNotifier(Offset.zero);
  final ValueNotifier<double> scaleNotifier = ValueNotifier(1.0);
  late final AnimationController xController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
  late final AnimationController yController = AnimationController(vsync: this, duration: const Duration(seconds: 2));

  late Size viewport = Size.zero;
  late Size size = Size(amountX * plateSize, amountY * plateSize);
  double flingSpeedX = 0;
  double flingSpeedY = 0;
  double lastTickX = 0;
  double lastTickY = 0;
  double currentScale = 1.0;

  @override
  void initState() {
    xController.addListener(() {
      double elapsedTime = xController.value - lastTickX;
      lastTickX = xController.value;
      double momentum = flingSpeedX * elapsedTime;
      _onScrolled(Offset(momentum, 0));
    });

    yController.addListener(() {
      double elapsedTime = yController.value - lastTickY;
      lastTickY = yController.value;
      double momentum = flingSpeedY * elapsedTime;
      _onScrolled(Offset(0, momentum));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        viewport = Size(constraints.maxWidth, constraints.maxHeight);
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onScaleStart: (details) {
            lastTickX = 0.0;
            lastTickY = 0.0;
            xController.reset();
            yController.reset();
          },
          onScaleUpdate: (details) {
            if (details.pointerCount == 1) {
              _onScrolled(details.focalPointDelta);
            }

            if (details.pointerCount == 2) {
              onScaleUpdate(details.scale);
            }
          },
          onScaleEnd: (details) {
            logMessage("ScaleEnd -> $details");
            if (details.pointerCount == 1) {
              _onPanEnd(details.velocity);
            }
            if (details.pointerCount == 2) {
              currentScale = scaleNotifier.value;
            }
          },
          child: ValueListenableBuilder<Offset>(
            valueListenable: scrollNotifier,
            builder: (context, offset, child) {
              return Stack(
                children: [
                  Positioned(
                    left: offset.dx,
                    top: offset.dy,
                    child: ValueListenableBuilder<double>(
                      valueListenable: scaleNotifier,
                      builder: (context, scale, child) {
                        return Transform(
                          transform: Matrix4.identity().scaled(scale, scale, scale),
                          child: child!,
                        );
                      },
                      child: child!,
                    ),
                  ),
                ],
              );
            },
            child: SizedBox(
              height: size.height,
              width: size.width,
              child: Grid(),
            ),
          ),
        );
      }),
    );
  }

  void _onScrolled(Offset delta) {
    var maxDx = size.width - viewport.width;
    var maxDy = size.height - viewport.height;
    Offset prior = scrollNotifier.value;
    double dx = min(0, max(-maxDx, prior.dx + delta.dx));
    double dy = min(0, max(-maxDy, prior.dy + delta.dy));
    scrollNotifier.value = Offset(dx, dy);
  }

  _onPanEnd(Velocity velocity) {
    flingSpeedX = velocity.pixelsPerSecond.dx;
    flingSpeedY = velocity.pixelsPerSecond.dy;
    trace("fling; $velocity; $flingSpeedX:$flingSpeedY");
    if (flingSpeedX != 0) {
      lastTickX = 0.0;
      xController.reset();
      xController.fling();
    }
    if (flingSpeedY != 0) {
      lastTickY = 0.0;
      yController.reset();
      yController.fling();
    }
  }

  void onScaleUpdate(double scale) {
    var origin = scale;
    var diff = (scale - 1) * 0.75;
    var calcelatedScale = currentScale + diff;
    var resultScale = min(max(calcelatedScale, 0.5), 1.0);
    scaleNotifier.value = resultScale;
    logMessage("S: $origin > $diff > $calcelatedScale > $resultScale");
  }
}

class Plate extends StatelessWidget {
  final int x;
  final int y;
  final Color color = randomSemiTransparentColor;

  Plate({Key? key, required int index})
      : x = index % amountX,
        y = index ~/ amountX,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: plateSize,
      height: plateSize,
      color: color,
      child: Center(
        child: Text("$x:$y", style: Theme.of(context).textTheme.bodySmall),
      ),
    );
  }
}

class Grid extends StatefulWidget {
  Grid({Key? key}) : super(key: key);

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  late final List<Plate> plates;

  @override
  void initState() {
    plates = List.generate(amountX * amountY, (index) => Plate(index: index));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: plateSize * amountX,
      height: plateSize * amountY,
      child: Stack(
        children: plates
            .map((plate) => Positioned(
                  width: plateSize,
                  height: plateSize,
                  left: plate.x * plateSize,
                  top: plate.y * plateSize,
                  child: plate,
                ))
            .toList(),
      ),
    );
  }
}
