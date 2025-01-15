import 'dart:async';
import 'dart:math';

import 'package:experiments/indexed_scrollable/indexed_scroll_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_commons/flutter_commons.dart';
import 'package:sprintf/sprintf.dart';

class IndexedScrollScreen extends StatefulWidget {
  const IndexedScrollScreen({super.key});

  @override
  State<IndexedScrollScreen> createState() => _IndexedScrollScreenState();
}

class _IndexedScrollScreenState extends State<IndexedScrollScreen> {
  final IndexedScrollController scrollController = IndexedScrollController(scrollDuration: Duration(milliseconds: 300));
  late List<String> items;
  double scrollToIndex = 0.0;

  @override
  void initState() {
    items = List.generate(1000, (index) => lorem(paragraphs: 1, words: 5 + randomizer.nextInt(25)));
    scrollToIndex = randomizer.nextInt(items.length) * 1.0 + randomizer.nextDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test D'),
        forceMaterialTransparency: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListenableBuilder(
            listenable: scrollController,
            builder: (context, child) {
              if (!scrollController.hasClients) {
                return SizedBox.shrink();
              }

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('offset -> ${scrollController.offset}'),
                    // Text('pixels -> ${scrollController.position.pixels}'),
                    // Text('devicePixelRatio -> ${scrollController.position.devicePixelRatio}'),
                    Text('maxScrollExtent -> ${scrollController.position.maxScrollExtent}'),
                    // Text('minScrollExtent -> ${scrollController.position.minScrollExtent}'),
                  ],
                ),
              );
            },
          ),
          VSpacer(12),
          VSpacer(1, color: Colors.black12),
          Expanded(
            child: NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                scrollController.cancelScroll();
                return false;
              },
              child: ListView.builder(
                controller: scrollController,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return scrollController.watch(
                    index: index,
                    child: Container(
                      color: randomSemiTransparentColor,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Text('$index --> ${items[index]}'),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text('Scroll to ${sprintf('%2.2f', [scrollToIndex])}'),
                    onPressed: () async {
                      scrollController.scrollTo(
                        scrollToIndex,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear,
                      );

                      setState(() {
                        scrollToIndex = randomizer.nextInt(items.length) * 1.0 + randomizer.nextDouble();
                      });
                    },
                  ),
                ),
                HSpacer(8),
                Expanded(
                  child: ElevatedButton(
                    child: Text('top'),
                    onPressed: () {
                      scrollController.scrollTo(0);
                      // scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.linear);
                    },
                  ),
                ),
                HSpacer(8),
                Expanded(
                  child: ElevatedButton(
                    child: Text('bottom'),
                    onPressed: () {
                      // listItemScrollWatcherController.scrollTo(
                      //   items.length - 1,
                      //   duration: Duration(milliseconds: 300),
                      //   context: context,
                      //   scrollController: scrollController,
                      // );
                      scrollController.animateTo(scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
