import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_commons/flutter_commons.dart';

import 'test_events.dart';
import 'test_state.dart';

class TestBloc extends Bloc<BlocEvent, TestState> {
  TestBloc() : super(TestState()) {
    on<OnInit>(onInit);
    on<Fire>(onFire);
  }

  @protected
  FutureOr<void> onInit(OnInit event, Emitter<TestState> emit) {}

  FutureOr<void> onFire(Fire event, Emitter<TestState> emit) {}
}
