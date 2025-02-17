import 'package:experiments/screens/animated_list_items.dart';
import 'package:experiments/screens/animated_list_screen.dart';
import 'package:experiments/screens/bloc_test/test_bloc.dart';
import 'package:experiments/screens/bloc_test/test_bloc_widget.dart';
import 'package:experiments/screens/collapsible_widget_screen.dart';
import 'package:experiments/screens/exp/list_screen.dart';
import 'package:experiments/screens/login_flow/auth/auth_screen.dart';
import 'package:experiments/screens/login_flow/auth/profile_screen.dart';
import 'package:experiments/screens/login_flow/sms/sms_bottom_sheet.dart';
import 'package:experiments/screens/login_flow/unauth/login_screen.dart';
import 'package:experiments/screens/login_flow/unauth/registration_screen.dart';
import 'package:experiments/screens/main/main_screen.dart';
import 'package:experiments/screens/remember_username_screen.dart';
import 'package:experiments/screens/swap_card_screen.dart';
import 'package:experiments/screens/indexed_scroll_screen.dart';
import 'package:experiments/screens/two_dimensional_scroll_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_commons/flutter_commons.dart';

class AppRoutes {
  AppRoutes._();

  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigator = GlobalKey<NavigatorState>(debugLabel: 'shell');
  static final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
  static final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');

  static final root = "/";
  static final screenA = "/screenA";
  static final screenB = "/screenB";
  static final screenC = "/screenC";
  static final screenD = "/screenD";
  static final animatedListScreen = "/animatedListScreen";
  static final rememberUsernameScreen = "/rememberUsernameScreen";
  static final testBloc = "/testBloc";
  static final ble = "/ble";
  static final appearing = '/appearing';
  static final animatedListItems = '/animated_list_items';
  static final mkScreen = '/mkScreen';


  static final List<RouteBase> screens = [
    GoRoute(
      path: root,
      redirect: (context, state) => screenA,
    ),
    GoRoute(
      path: screenA,
      builder: (context, state) {
        return ScreenA();
      },
    ),
    GoRoute(
      path: screenC,
      builder: (context, state) {
        return SwapCardScreen();
      },
    ),
    GoRoute(
      path: screenD,
      builder: (context, state) {
        return IndexedScrollScreen();
      },
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: IndexedScrollScreen(),
      ),
    ),
    GoRoute(
      path: screenB,
      builder: (context, state) {
        return TwoDimensionalScrollScreen();
      },
    ),
    GoRoute(
      path: animatedListScreen,
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: AnimatedListScreen(),
      ),
    ),
    GoRoute(
      path: rememberUsernameScreen,
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: RememberUsernameScreen(),
      ),
    ),
    GoRoute(
      path: testBloc,
      pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: TestScreen(),
      ),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
      routes: [
        GoRoute(path: 'registration', builder: (context, state) => RegistrationScreen()),
        GoRoute(path: 'forgot-password', builder: (context, state) => RegistrationScreen()),
      ],
    ),
    GoRoute(
      path: '/sms',
      name: '/sms',
      pageBuilder: (context, state) => BottomSheetPage(
        name: state.name,
        arguments: state.extra,
        builder: (context) => SmsBottomSheet(),
      ),
    ),
    GoRoute(
      path: '/auth/:phone',
      builder: (context, state) => AuthScreen(phone: state.pathParameters['phone']!),
      routes: [
        GoRoute(path: 'profile', builder: (context, state) => ProfileScreen(phone: state.pathParameters['phone']!)),
      ],
    ),
    GoRoute(
      path: '/appearing',
      builder: (context, state) => CollapsibleWidgetScreen(),
    ),
    GoRoute(
      path: '/animated_list_items',
      name: '/animated_list_items',
      builder: (context, state) => AnimatedListItems(),
    ),
    GoRoute(
      path: '/mkScreen',
      name: '/mkScreen',
      builder: (context, state) => ListScreen(),
    ),
  ];



  static CustomTransitionPage buildPageWithDefaultTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: Duration(seconds: 1),
      reverseTransitionDuration: Duration(seconds: 1),
      transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(begin: Offset(1, -.1), end: Offset(0, 0)).animate(CurveTween(curve: Curves.fastOutSlowIn).animate(animation)),
          child: child,
        ),
      ), // FadeTransition(opacity: animation, child: child),
    );
  }
}
