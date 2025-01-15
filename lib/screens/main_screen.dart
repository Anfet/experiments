import 'package:experiments/app/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commons/flutter_commons.dart';

class ScreenA extends StatefulWidget {
  ScreenA({Key? key}) : super(key: key);

  @override
  State<ScreenA> createState() => _ScreenAState();
}

class _ScreenAState extends State<ScreenA> with MountedCheck {
  AppearingController _appearingController = AppearingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () => _appearingController.restartAnimation(), icon: Icon(Icons.refresh)),
        ],
      ),
      body: SlidingWidget(
        orientation: SlidingOrientation.topToBottom,
        duration: 1500.milliseconds,
        builder: (context, child, animation) {
          return Opacity(opacity: animation.value, child: child);
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VSpacer(36),
              ElevatedButton(
                onPressed: () => router.to_2d_scroll(),
                child: Center(
                  child: Text("To 2D scroll view"),
                ),
              ),
              VSpacer(12),
              ElevatedButton(
                onPressed: () => router.to_indexed_scroll(),
                child: Center(
                  child: Text("To indexed scroll view"),
                ),
              ),
              VSpacer(12),
              ElevatedButton(
                onPressed: () => router.to_2d_scroll(),
                child: Center(
                  child: Text("To card swap view"),
                ),
              ),
              VSpacer(12),
              ElevatedButton(
                onPressed: () => router.toAnimatedListScreen(),
                child: Center(
                  child: Text("To animated list"),
                ),
              ),
              VSpacer(12),
              ElevatedButton(
                onPressed: () => router.toRememberPassword(),
                child: Center(
                  child: Text("To remember password"),
                ),
              ),
              VSpacer(12),
              ElevatedButton(
                onPressed: () => router.toTestBloc(),
                child: Center(
                  child: Text("To test bloc"),
                ),
              ),
              VSpacer(12),
              ElevatedButton(
                onPressed: () => router.toBle(),
                child: Center(
                  child: Text("To BLE"),
                ),
              ),
              VSpacer(24),
              ElevatedButton(
                onPressed: () => router.toAppearing(),
                child: Center(
                  child: Text("To Appearing Widget"),
                ),
              ),
              VSpacer(24),
              ElevatedButton(
                onPressed: () => router.toAnimatedListItems(),
                child: Center(
                  child: Text("To Animated List items"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
