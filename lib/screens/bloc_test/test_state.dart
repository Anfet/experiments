import 'package:flutter/foundation.dart';
import 'package:flutter_commons/flutter_commons.dart';

@immutable
class TestState implements BlocState {

  final BlocReaction? fire;

  const TestState({
    this.fire,
  });

  TestState copyWith({
    BlocReaction? fire,
  }) {
    return TestState(
      fire: fire ?? this.fire,
    );
  }
}