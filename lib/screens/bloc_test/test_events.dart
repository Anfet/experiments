import 'package:flutter_commons/flutter_commons.dart';

class TestEvents implements BlocEvent {
  TestEvents._();

  factory TestEvents.fire() => Fire._();
}

class Fire extends TestEvents {
  Fire._() : super._();
}
