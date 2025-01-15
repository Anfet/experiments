enum DiffUtilActionEnum { add, remove }

class DiffUtilAction<T> {
  final DiffUtilActionEnum action;
  final int index;
  final T item;

  DiffUtilAction._({
    required this.action,
    required this.item,
    required this.index,
  });

  factory DiffUtilAction.add(int index, T item) => DiffUtilAction<T>._(action: DiffUtilActionEnum.add, item: item, index: index);

  factory DiffUtilAction.remove(int index, T item) => DiffUtilAction<T>._(action: DiffUtilActionEnum.remove, item: item, index: index);

  @override
  String toString() {
    return '${action == DiffUtilActionEnum.add ? "+" : "-"}$item($index)';
  }

  void applyTo(List<T> items) {
    switch (action) {
      case DiffUtilActionEnum.add:
        items.insert(index, item);
        break;
      case DiffUtilActionEnum.remove:
        items.removeAt(index);
        break;
    }
  }
}

class DiffUtil<T> {
  List<DiffUtilAction<T>> calculateDiff(List<T> previous, List<T> current) {
    var result = <DiffUtilAction<T>>[];

    var old = List.of(previous);
    var actual = List.of(current);
    var index = 0;
    var oldIndex = 0;

    while (index < current.length) {
      var item = actual[index];
      if (previous.isEmpty || index >= old.length) {
        result.add(DiffUtilAction.add(index, item));
        index++;
        continue;
      }

      var oldItem = old[oldIndex];
      if (item == oldItem) {
        index++;
        oldIndex++;
        continue;
      }

      var oldIndexOfActual = old.indexOf(item, oldIndex + 1);
      if (oldIndexOfActual == -1) {
        result.add(DiffUtilAction.add(index, item));
        old.insert(index, item);
        index++;
        oldIndex++;
        continue;
      }

      for (var d = oldIndex; d < oldIndexOfActual; d++) {
        result.add(DiffUtilAction.remove(oldIndex, old[oldIndex]));
        old.removeAt(oldIndex);
      }
      index++;
      oldIndex = index;
    }

    if (index < old.length) {
      for (var i = 0; i < old.length - index; i++) {
        result.add(DiffUtilAction.remove(index, old[index + i]));
      }
    }

    return result;
  }
}

extension ListExt<T> on List<T> {
  bool equals(List<T> other) {
    if (this.length != other.length) {
      return false;
    }

    for (var i = 0; i < length; i++) {
      if (this[i] != other[i]) {
        return false;
      }
    }
    return true;
  }
}
