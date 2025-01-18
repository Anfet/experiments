import 'package:experiments/app/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commons/flutter_commons.dart';

class ScreenA extends StatefulWidget {
  ScreenA({Key? key}) : super(key: key);

  @override
  State<ScreenA> createState() => _ScreenAState();
}

class _ScreenAState extends State<ScreenA> with MountedCheck {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: markNeedsRebuild, icon: Icon(Icons.refresh)),
        ],
      ),
      body: Column(
        key: UniqueKey(),
        spacing: 12,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          VSpacer(8),
          SlidingWidget(
            duration: 500.milliseconds,
            orientation: SlidingOrientation.topToBottom,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: ElevatedButton(
                onPressed: () => router.to_2d_scroll(),
                child: Center(
                  child: Text("To 2D scroll view"),
                ),
              ),
            ),
          ),
          ...[
            ElevatedButton(
              onPressed: () => router.to_indexed_scroll(),
              child: Center(
                child: Text("To indexed scroll view"),
              ),
            ),
            ElevatedButton(
              onPressed: () => router.to_2d_scroll(),
              child: Center(
                child: Text("card swap view"),
              ),
            ),
            ElevatedButton(
              onPressed: () => router.toAnimatedListScreen(),
              child: Center(
                child: Text("animated list"),
              ),
            ),
            ElevatedButton(
              onPressed: () => router.toRememberPassword(),
              child: Center(
                child: Text("remember password"),
              ),
            ),
            ElevatedButton(
              onPressed: () => router.toTestBloc(),
              child: Center(
                child: Text("test bloc"),
              ),
            ),
            ElevatedButton(
              onPressed: () => router.toAppearing(),
              child: Center(
                child: Text("appearting widget"),
              ),
            ),
          ].mapIndexed(
            (i, e) => SlidingWidget(
              duration: 1.seconds,
              delay: (500 + i * 100).milliseconds,
              orientation: [SlidingOrientation.leftToRight, SlidingOrientation.rightToLeft].randomElement,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: e,
              ),
            ),
          ),
          Spacer(),
          SlidingWidget(
            orientation: SlidingOrientation.bottomToTop,
            duration: 1.seconds,
            delay: 1500.milliseconds,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: ElevatedButton(
                onPressed: () => router.toAnimatedListItems(),
                child: Center(
                  child: Text("animated list item width"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
