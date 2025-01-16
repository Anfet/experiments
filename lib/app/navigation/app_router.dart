import 'package:experiments/app/navigation/app_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_commons/flutter_commons.dart';
import 'package:flutter_di/flutter_di.dart';

AppRouter get router => RootScope.find<AppRouter>();

abstract class AppRouter {
  void pop([dynamic result]);

  void restart();

  void navigateToA();

  void to_2d_scroll();

  void to_swap_card();

  void to_indexed_scroll();

  void toAnimatedListScreen();

  void toRememberPassword();

  void toTestBloc();

  void to(String name);

  Future push(String path);

  toAppearing();

  toAnimatedListItems();
}

class AppRouterImpl implements AppRouter {
  final GoRouter _router;

  AppRouterImpl(this._router);

  void pop([dynamic result]) => _router.pop(result);

  void restart() => _router.pushReplacement("/");

  void navigateToA() => _router.goNamed(AppRoutes.screenA);

  void to_2d_scroll() => _router.push(AppRoutes.screenB);

  void to_swap_card() => _router.push(AppRoutes.screenC);

  void to_indexed_scroll() => _router.push(AppRoutes.screenD);

  void toRememberPassword() => _router.push(AppRoutes.rememberUsernameScreen);

  @override
  void toAnimatedListScreen() {
    _router.push(AppRoutes.animatedListScreen);
  }

  @override
  void toTestBloc() {
    _router.push(AppRoutes.testBloc);
  }

  @override
  void toBle() => _router.push(AppRoutes.ble);

  @override
  void to(String name) {
    _router.go(name);
  }

  @override
  Future push(String path) {
    return _router.push(path);
  }

  @override
  toAppearing() {
    return _router.push(AppRoutes.appearing);
  }

  @override
  toAnimatedListItems() {
    return _router.push(AppRoutes.animatedListItems);
  }
}

class AppRouterObserver extends NavigatorObserver with Logging {
  @override
  void didPush(Route route, Route? previousRoute) {
    trace("pushed - ${route.settings}; prior - ${previousRoute?.settings}");
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    trace("popped - ${route.settings}; prior - ${previousRoute?.settings}");
    super.didPop(route, previousRoute);
  }
}
