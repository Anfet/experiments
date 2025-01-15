import 'dart:async';

import 'package:flutter_commons/flutter_commons.dart';

extension FutureIterableExt<T> on Future<Iterable<T>> {
  Future<Iterable<X>> map<X>(FutureOr<X> Function(T item) mapper) => then((old) {
        return old.asyncMap<X>((e) async => mapper(e)).toList();
      });
}
