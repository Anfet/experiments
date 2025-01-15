import 'package:flutter/material.dart';
import 'package:flutter_commons/flutter_commons.dart';

class SmsBottomSheet extends StatefulWidget {
  const SmsBottomSheet({super.key});

  @override
  State<SmsBottomSheet> createState() => _SmsBottomSheetState();
}

class _SmsBottomSheetState extends State<SmsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(.5),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}

class BottomSheetPage<T> extends Page<T> {
  final WidgetBuilder builder;

  const BottomSheetPage({
    required this.builder,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) => ModalBottomSheetRoute(
        elevation: 4,
        builder: builder,
        settings: this,
        isScrollControlled: false,
        isDismissible: true,
        useSafeArea: true,
        showDragHandle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        sheetAnimationStyle: AnimationStyle(
          duration: 1.seconds,
          curve: Curves.decelerate,
        ),
      );
}
