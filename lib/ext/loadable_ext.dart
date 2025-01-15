import 'package:flutter_commons/flutter_commons.dart';

extension LoadableBoolExt on Loadable<bool>{

  bool call() => value ?? false;
}