
import 'package:experiments/utils/diff_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef AnimatedListItemBuilderFunc<T> = Widget Function(BuildContext context, T item, Animation<double> animation, {int? index});

class AnimatedListEx<T> extends StatefulWidget {
  final List<T> items;
  final AnimatedListItemBuilderFunc<T> itemBuilder;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsets? padding;
  final Clip clipBehavior;
  final Duration? insertItemDuration;
  final Duration? removeItemDuration;
  final bool insertInSequience;
  final bool removeInSequience;
  final Duration? insertRemoveDiff;

  AnimatedListEx({
    super.key,
    required this.itemBuilder,
    required this.items,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.clipBehavior = Clip.hardEdge,
    this.insertItemDuration,
    this.removeItemDuration,
    this.insertInSequience = true,
    this.removeInSequience = true,
    this.insertRemoveDiff,
  }) {
    assert(!this.insertInSequience || (this.insertItemDuration != null));
    assert(!this.removeInSequience || (this.removeItemDuration != null));
  }

  @override
  State<AnimatedListEx<T>> createState() => _AnimatedListExState<T>();
}

class _AnimatedListExState<T> extends State<AnimatedListEx<T>> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  late List<T> items;

  @override
  void initState() {
    items = widget.items;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AnimatedListEx<T> oldWidget) {
    doDiff(items, widget.items);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: items.length,
      itemBuilder: (context, index, animation) => widget.itemBuilder(context, items[index], animation, index: index),
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      controller: widget.controller,
      primary: widget.primary,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      padding: widget.padding,
      clipBehavior: widget.clipBehavior,
    );
  }

  Future<void> doDiff(List<T> oldItems, List<T> actual) async {
    final state = _listKey.currentState;
    if (state == null) {
      return;
    }

    var actions = DiffUtil().calculateDiff(oldItems, actual);
    for (var act in actions) {
      act.applyTo(items);
      switch (act.action) {
        case DiffUtilActionEnum.add:
          state.insertItem(act.index, duration: widget.insertItemDuration ?? const Duration(milliseconds: 300));
          if (widget.insertInSequience) {
            await Future.delayed(widget.insertItemDuration! - (widget.insertRemoveDiff ?? Duration.zero));
          }
          break;
        case DiffUtilActionEnum.remove:
          state.removeItem(
            act.index,
            (context, animation) => widget.itemBuilder(context, act.item, animation, index: act.index),
            duration: widget.removeItemDuration ?? const Duration(milliseconds: 300),
          );
          if (widget.removeInSequience) {
            await Future.delayed(widget.removeItemDuration! - (widget.insertRemoveDiff ?? Duration.zero));
          }
          break;
      }
    }
  }
}
