import 'dart:math';

import 'package:flutter_commons/flutter_commons.dart';

class RangeSplitter<T> with Logging {
  List<Segment<T>> _segments = [];

  List<Segment<T>> get segments => List.of(_segments);

  RangeSplitter();

  void add(int ax, int bx, List<T> data) {
    if (ax >= bx) {
      return;
    }

    if (_segments.isEmpty) {
      _segments.add(Segment(ax, bx, data));
      return;
    }

    var a = _segments.first.a;
    var b = _segments.last.b;

    if (_prepend(ax, bx, a, data) || _postpend(ax, bx, b, data)) {
      return;
    }

    ax = max(ax, a);
    bx = min(bx, b);

    //now only part inside is variable
    var idx = -1;
    while (idx < _segments.length) {
      if (ax >= bx) {
        //we are done
        break;
      }

      idx++;
      var segment = segments[idx];
      var a = segment.a;
      var b = segment.b;

      assert(ax >= a, "error. ax < a; index=$idx, ax=$ax, a=$a");

      if (ax >= b) {
        //skip
        continue;
      }

      if (ax < a) {
        break;
      }

      if (bx <= b) {
        //this segment consumes ours, we need to split
        var s1 = Segment<T>(a, ax, segment.data);
        var s2 = Segment<T>(ax, bx, segment.data + data);
        var s3 = Segment<T>(bx, b, segment.data);
        var s = <Segment<T>>[
          if (s1.length > 0) s1,
          if (s2.length > 0) s2,
          if (s3.length > 0) s3,
        ];
        _segments.removeAt(idx);
        _segments.insertAll(idx, s);
        break;
      }

      if (ax == a) {
        //our segment consumes this
        _segments[idx] = Segment(a, b, segment.data + data);
        ax = b;
        continue;
      }

      if (ax > a) {
        _segments[idx] = Segment(ax, b, segment.data);
        _segments.insert(idx, Segment(a, ax, segment.data));
        continue;
      }

      throw IllegalArgumentException("should not happend");
    }
  }

  bool _prepend(int ax, int bx, int a, List<T> data) {
    if (ax < a) {
      if (bx <= a) {
        if (bx < a) {
          _segments.insert(0, Segment<T>(bx, a));
        }
        _segments.insert(0, Segment<T>(ax, bx, data));
        return true;
      } else {
        _segments.insert(0, Segment<T>(ax, a, data));
      }
    }

    return false;
  }

  bool _postpend(int ax, int bx, int b, List<T> data) {
    if (ax > b) {
      _segments.add(Segment<T>(b, ax));
      _segments.add(Segment<T>(ax, bx, data));

      return true;
    }

    if (bx > b) {
      _segments.add(Segment<T>(b, bx, data));
    }

    return false;
  }
}

class Segment<T> {
  final int a;
  final int b;
  final List<T> data;

  int get length => b - a;

  bool intersectsWith(Segment other) => !(a > other.b || b < other.a);

  bool canConsume(Segment other) => a <= other.a && b >= other.b;

  Segment<T> copyWith({
    int? a,
    int? b,
    List<T>? data,
  }) =>
      Segment(a ?? this.a, b ?? this.b, data ?? this.data);

  Segment(this.a, this.b, [List<T>? data]) : data = data ?? <T>[];

  @override
  String toString() {
    return '$a - $b, [$data]';
  }
}
