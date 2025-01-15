import 'package:flutter/foundation.dart';
import 'package:flutter_commons/flutter_commons.dart';

class Segmenter<T> {
  final List<Segment<T>> segments = [];

  int get start => segments.first.a;

  int get end => segments.last.b;

  void add(int a, int b, List<T> items) {
    assert(a < b, '$a must be less than $b');

    if (segments.isEmpty) {
      segments.add(Segment<T>(a, b, items));
      return;
    }

    var idx = 0;
    while (idx < segments.length) {
      var segment = segments[idx];
      var sa = segment.a;
      var sb = segment.b;

      if (b < sa) {
        _prepend(a, b, items);
        return;
      }

      if (a >= sb) {
        idx++;
        continue;
      }

      if (a < sa) {
        var pre = Segment(a, sa, items);
        segments.insert(0, pre);
        a = sa;
        idx++;
        continue;
      }

      if (a > sa) {
        var pre = Segment(sa, a, segment.items);
        segments.insert(idx, pre);
        idx++;
        segment = segment.copyWith(a: a);
        segments[idx] = segment;
        continue;
      }

      if (b >= sb) {
        segment = segment.copyWith(items: segment.items + items);
        segments[idx] = segment;
        idx++;
        a = sb;
        continue;
      }

      if (b == sb) {
        segment = segment.copyWith(items: segment.items + items);
        segments[idx] = segment;
        return;
      }

      if (b < sb) {
        var mid = Segment(a, b, segment.items + items);
        var post = Segment(b, sb, segment.items);
        segments.removeAt(idx);
        segments.insertAll(idx, [mid, post]);
        return;
      }

      throw IllegalArgumentException("should not happend");
    }

    if (a != b) _postpend(a, b, items);
  }

  void _prepend(int a, int b, List<T> items) {
    var middleLenght = start - b;
    if (middleLenght > 0) {
      segments.insert(0, Segment<T>(b, start, []));
    }

    segments.insert(0, Segment(a, b, items));
  }

  void _postpend(int a, int b, List<T> items) {
    var middle = a - end;
    if (middle > 0) {
      segments.add(Segment<T>(end, a, []));
    }

    segments.add(Segment<T>(a, b, items));
  }

  Segment<T>? segmentAt(int x) => segments.firstIf((it) => x >= it.a && x < it.b);

  List<Segment<T>> segmentsInRange(int a, int b) => segments.filter((segment) => !(segment.b <= a || segment.a >= b));
}

@immutable
class Segment<T> {
  final int a;
  final int b;
  final List<T> items;

  Segment(this.a, this.b, this.items) {
    assert(a < b, "$a must be less than $b");
  }

  Segment<T> copyWith({
    int? a,
    int? b,
    List<T>? items,
  }) {
    return Segment<T>(
      a ?? this.a,
      b ?? this.b,
      items ?? this.items,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Segment && runtimeType == other.runtimeType && a == other.a && b == other.b && items == other.items;

  @override
  int get hashCode => a.hashCode ^ b.hashCode ^ items.hashCode;

  @override
  String toString() {
    return '[$a:$b] $items';
  }
}
