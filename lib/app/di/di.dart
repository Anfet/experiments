import 'dart:io';

import 'package:experiments/app/navigation/app_router.dart';
import 'package:experiments/app/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commons/flutter_commons.dart';
import 'package:flutter_di/flutter_di.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:window_manager/window_manager.dart';

const appScope = "App";

Future<void> configureDependencies() async {
  var router = GoRouter(
    routes: AppRoutes.screens,
    initialLocation: '/',
    debugLogDiagnostics: true,
    navigatorKey: AppRoutes.rootNavigatorKey,
    observers: [AppRouterObserver()],
  );

  RootScope.replace<GoRouter>(router);
  RootScope.replace<AppRouter>(AppRouterImpl(router));

  if (Platform.isWindows) {
    var size = Size(1170, 2532) * .3;
    WindowOptions windowOptions = WindowOptions(
      backgroundColor: Colors.black,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      fullScreen: false,
      center: false,
      windowButtonVisibility: true,
      alwaysOnTop: false,
      title: 'Experiments',
      maximumSize: size,
      minimumSize: size,
      size: size,
    );

    await Future.wait([
      WindowManager.instance.setMaximizable(false),
      WindowManager.instance.setResizable(false),
    ]);

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      // await windowManager.setIcon(Assets.imagesIconIsk);
      await windowManager.show();
      await windowManager.focus();
    });
  }
}

final timestampFormatter = DateFormat("yyyy-MM-dd HH:mm:ss", "en");
final dateFormatter = DateFormat("yyyy-MM-dd", "en");

class ClassNotRegisteredWithinGet extends AppException {
  ClassNotRegisteredWithinGet(super.message);
}
