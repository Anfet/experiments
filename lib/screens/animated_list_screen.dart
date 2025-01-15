import 'package:experiments/app/animated_listview_ex/animated_list_ex.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_commons/flutter_commons.dart';

class AnimatedListScreen extends StatefulWidget {
  const AnimatedListScreen({super.key});

  @override
  State<AnimatedListScreen> createState() => _AnimatedListScreenState();
}

class _AnimatedListScreenState extends State<AnimatedListScreen> {
  List<String> items = [];

  @override
  void initState() {
    scheduleOnNextFrame(addElements);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animated list')),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    child: AnimatedListEx<String>(
                      items: items,
                      itemBuilder: itemBuilder,
                      removeInSequience: items.isEmpty ? false : true,
                      insertInSequience: true,
                      insertItemDuration: Duration(milliseconds: 300),
                      removeItemDuration: Duration(milliseconds: 300),
                      insertRemoveDiff: Duration(milliseconds: 100),
                    ),
                  ),
                  if (items.isEmpty)
                    Positioned.fill(
                      child: ColoredBox(
                        color: randomSemiTransparentColor,
                        child: Center(child: Text('empty')),
                      ),
                    ),
                ],
              ),
            ),
            VSpacer(12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: addElements,
                      child: Text('add'),
                    ),
                  ),
                  HSpacer(12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: removeAll,
                      child: Text('clear'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, String item, animation, {int? index}) {
    var text = item;
    var textStyle = Theme.of(context).textTheme.bodySmall;
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(text.hashCode.isEven ? -1 : 1, 0), end: Offset(0, 0)).animate(animation),
      child: Container(
        color: Color(0xff000000 + item.hashCode).withOpacity(.15),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(text, style: textStyle),
        ),
      ),
    );
  }

  Future<void> addElements() async {
    var newItems = List.generate(randomizer.nextInt(2) + 5, (index) => lorem(paragraphs: 1, words: randomizer.nextInt(50))).reversed;

    setState(() {
      items.insertAll(0, newItems);
    });
  }

  Future<void> removeAll() async {
    setState(() {
      items = [];
    });
  }
}
