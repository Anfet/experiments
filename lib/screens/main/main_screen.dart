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
            spacing: 12,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => router.to_2d_scroll(),
                child: Center(
                  child: Text("To 2D scroll view"),
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
                onPressed: () => router.toAnimatedListItems(),
                child: Center(
                  child: Text("animated list item width"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
