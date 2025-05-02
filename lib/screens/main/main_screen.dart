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
      body: GridView(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
        children: [
          SlidingWidget(
            duration: 500.milliseconds,
            orientation: SlidingOrientation.topToBottom,
            child: ElevatedButton(
              onPressed: () => router.to_2d_scroll(),
              child: Center(
                child: Text("To 2D scroll view"),
              ),
            ),
          ),
          ...[
            ElevatedButton(
              onPressed: () => router.toAnimatedRouting(),
              child: Center(
                child: Text("Animated routing"),
              ),
            ),
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
            ElevatedButton(
              onPressed: () => router.toMkList(),
              child: Center(
                child: Text("mk screen"),
              ),
            ),
            ElevatedButton(
              onPressed: () => router.toItemMove(),
              child: Center(
                child: Text("Item move"),
              ),
            ),

            ElevatedButton(
              onPressed: () => router.toHeroMain(),
              child: Center(
                child: Text("Hero main"),
              ),
            ),
          ].mapIndexed(
            (i, e) => SlidingWidget(
              duration: 1.seconds,
              delay: 500.milliseconds,
              orientation: [SlidingOrientation.leftToRight, SlidingOrientation.rightToLeft].randomElement,
              child: e,
            ),
          ),
          SlidingWidget(
            orientation: SlidingOrientation.bottomToTop,
            duration: 1.seconds,
            delay: 1500.milliseconds,
            child: ElevatedButton(
              onPressed: () => router.toAnimatedListItems(),
              child: Center(
                child: Text("animated list item width", textAlign: TextAlign.center),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
