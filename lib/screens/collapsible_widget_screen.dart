import 'package:experiments/app/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commons/flutter_commons.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class CollapsibleWidgetScreen extends StatefulWidget {
  const CollapsibleWidgetScreen({super.key});

  @override
  State<CollapsibleWidgetScreen> createState() => _CollapsibleWidgetScreenState();
}

class _CollapsibleWidgetScreenState extends State<CollapsibleWidgetScreen> with MountedCheck, Logging, SingleTickerProviderStateMixin {
  List<String> texts = List.generate(10, (index) => lorem(words: random.nextInt(50) + 20, paragraphs: 2));
  List<bool> expanded = List.generate(10, (index) => true);
  List<Color> colors = List.generate(10, (index) => randomSemiTransparentColor);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: router.pop, icon: Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(
              onPressed: () {
                // var changeCollapse = random.nextBool();
                // var changeText = random.nextBool();
                // if (changeCollapse) collapsed[0] = !collapsed[0];
                // if (changeText)
                var index = random.nextInt(texts.length);
                if (!expanded[index]) {
                  texts[index] =
                      lorem(words: 10 + random.nextInt(25) + 10 + random.nextInt(25) + random.nextInt(25) + random.nextInt(25), paragraphs: 1);
                }
                expanded[index] = !expanded[index];
                markNeedsRebuild();
              },
              icon: Icon(Icons.history_toggle_off))
        ],
      ),
      body: RevealingWidget(
        duration: 3000.milliseconds,
        child: ListView(

          children: [
            ...texts.mapIndexed(
              (i, e) => SlidingWidget(
                key: ValueKey(i),
                duration: 1000.milliseconds,
                orientation: i == 0
                    ? SlidingOrientation.topToBottom
                    : i == texts.length - 1
                        ? SlidingOrientation.bottomToTop
                        : [SlidingOrientation.leftToRight, SlidingOrientation.rightToLeft].randomElement,
                child: Container(
                  // key: ValueKey(UniqueKey()),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  color: colors[i],
                  child: Text(texts[i]),
                ),
                // delay: (300 * i).milliseconds,
                // child: CollapsibleWidget(
                //   expanded: expanded[i],
                //   duration: 1000.milliseconds,
                //   child: Container(
                //     // key: ValueKey(UniqueKey()),
                //     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                //     color: colors[i],
                //     child: Text(texts[i]),
                //   ),
                //   builder: (animation, child) {
                //     return Opacity(opacity: animation.value, child: child);
                //   },
                // ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
