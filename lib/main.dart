import 'dart:io';

import 'package:experiments/app/di/di.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_di/flutter_di.dart';

import 'package:window_manager/window_manager.dart';

import 'app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
  }
  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (context, theme) {
        return OKToast(
          position: ToastPosition.center,
          backgroundColor: Colors.black,
          textStyle: theme.styles.themeData.textTheme.titleMedium,
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: RootScope.find<GoRouter>(),
            title: "Experiments",
            theme: theme.styles.themeData,
          ),
        );
      },
    );
  }
}
