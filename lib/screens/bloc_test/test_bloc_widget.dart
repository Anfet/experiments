import 'package:experiments/screens/bloc_test/test_events.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_commons/flutter_commons.dart';

import 'test_bloc.dart';
import 'test_state.dart';

class TestScreen extends BlocWidget<TestState, TestBloc> {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends BlocWidgetState<TestState, TestBloc, TestScreen> {
  @override
  void onReactions(BuildContext context, TestState previous, TestState state) {
    state.fire?.consume((value) {
      showToast('fired');
    });
  }

  @override
  Widget buildContent(BuildContext context, TestState state) {
    return Scaffold(
      body: SafeArea(
        child: ElevatedButton(
          onPressed: () {
            bloc.add(TestEvents.fire());
          },
          child: Text('TEST'),
        ),
      ),
    );
  }

  @override
  TestBloc onCreateBloc(BuildContext context) {
    return TestBloc();
  }
}
