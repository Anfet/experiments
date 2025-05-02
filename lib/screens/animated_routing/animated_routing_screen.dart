import 'package:experiments/app_theme.dart';
import 'package:experiments/app_typography.dart';
import 'package:experiments/screens/animated_routing/list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_commons/flutter_commons.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:oktoast/oktoast.dart';
import 'package:uuid/uuid.dart';

class AnimatedRoutingScreen extends StatefulWidget {
  const AnimatedRoutingScreen({super.key});

  @override
  State<AnimatedRoutingScreen> createState() => _AnimatedRoutingScreenState();
}

class _AnimatedRoutingScreenState extends State<AnimatedRoutingScreen> with MountedCheck, TickerProviderStateMixin {
  var itemsInCart = 0;
  var cartIconKey = GlobalKey(debugLabel: 'cartIconKey');
  var listA = <Map<String, dynamic>>[];
  var listB = <Map<String, dynamic>>[];
  bool first = false;
  OverlayEntry? overlayEntry;
  late AnimationController overlayAnimationController = AnimationController(vsync: this, duration: 1000.milliseconds);
  late AnimationController transitionController = AnimationController(vsync: this, duration: 400.milliseconds);
  late Animation<double> scaleAnimation = TweenSequence([
    TweenSequenceItem(tween: Tween(begin: 1.0, end: .6), weight: .25),
    TweenSequenceItem(tween: Tween(begin: .6, end: .6), weight: .75),
    TweenSequenceItem(tween: Tween(begin: .6, end: 1.0), weight: .25),
  ]).animate(overlayAnimationController);
  late Animation<Rect?> positionAnimation;

  late Animation<double> pageAtransition = TweenSequence([
    TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: .25),
    TweenSequenceItem(tween: Tween(begin: 0.0, end: -1.0), weight: .75),
    TweenSequenceItem(tween: Tween(begin: -1.0, end: -1.0), weight: .25),
  ]).animate(transitionController);

  late Animation<double> pageBtransition = TweenSequence([
    TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: .25),
    TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: .75),
    TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: .25),
  ]).animate(transitionController);

  String? animatingItem;

  @override
  void initState() {
    listA = List.generate(
      random.nextInt(10) + 3,
      (index) {
        return {
          'id': Uuid().v1().toString(),
          'title': lorem(paragraphs: 1, words: random.nextInt(10) + 1),
          'status': lorem(paragraphs: 1, words: 1),
          'a': random.nextInt(11000),
          'b': random.nextInt(11000),
          'subText': lorem(paragraphs: 1, words: 20),
        };
      },
    );

    listB = List.generate(
      random.nextInt(10) + 3,
      (index) {
        return {
          'id': Uuid().v1().toString(),
          'title': lorem(paragraphs: 1, words: random.nextInt(10) + 1),
          'status': lorem(paragraphs: 1, words: 1),
          'a': random.nextInt(11000),
          'b': random.nextInt(11000),
          'subText': lorem(paragraphs: 1, words: 20),
        };
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Routing'),
        actions: [
          _CartIcon(items: 12, key: cartIconKey),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                AnimatedBuilder(
                  animation: pageAtransition,
                  builder: (context, child) {
                    return FractionalTranslation(
                      translation: Offset(pageAtransition.value, 0),
                      child: child!,
                    );
                  },
                  child: ListView.builder(
                    key: ValueKey(listA.hashCode),
                    itemBuilder: (context, index) {
                      var item = listA[index];
                      var isPlaceholder = animatingItem == item['id'];
                      return AnimatedOpacity(
                        duration: 300.milliseconds,
                        opacity: isPlaceholder ? 0 : 1,
                        child: ListItem(
                          title: item['title'],
                          status: item['status'],
                          a: item['a'],
                          b: item['b'],
                          subText: item['subText'],
                          contextProvider: (value) {
                            item['context'] = value;
                          },
                          isPlaceholder: isPlaceholder,
                          size: isPlaceholder ? (item['context'].findRenderObject() as RenderBox).size : Size.zero,
                          onTap: (context) => pullItem(context, item['id']),
                        ),
                      );
                    },
                    itemCount: listA.length,
                  ),
                ),
                AnimatedBuilder(
                  animation: pageAtransition,
                  builder: (context, child) {
                    return FractionalTranslation(
                      translation: Offset(pageBtransition.value, 0),
                      child: child!,
                    );
                  },
                  child: ListView.builder(
                    key: ValueKey(listB.hashCode),
                    itemBuilder: (context, index) {
                      var item = listB[index];
                      var isPlaceholder = animatingItem == item['id'];
                      return AnimatedOpacity(
                        duration: 300.milliseconds,
                        opacity: isPlaceholder ? 0 : 1,
                        child: ListItem(
                          title: item['title'],
                          status: item['status'],
                          a: item['a'],
                          b: item['b'],
                          subText: item['subText'],
                          contextProvider: (value) {
                            item['context'] = value;
                          },
                          isPlaceholder: isPlaceholder,
                          size: isPlaceholder ? (item['context'].findRenderObject() as RenderBox).size : Size.zero,
                          onTap: (context) => pullItem(context, item['id']),
                        ),
                      );
                    },
                    itemCount: listB.length,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              spacing: 8,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => flip(),
                    child: Text('Flip'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => remake(),
                    child: Text('Remake'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future pullItem(BuildContext itemContext, String id) async {
    itemContext.ensureVisible(duration: 500.milliseconds, alignment: .5, curve: Curves.decelerate);
    if (overlayEntry != null) {
      removeHighlightOverlay();
    } else {
      var item = listA.firstWhere((it) => it['id'] == id);
      listB.insert(0, item);
      createHighlightOverlay(item['context'], item);
      flip();

      overlayAnimationController.forward(from: 0).orCancel.then(
        (value) {
          listA.removeWhere((it) => it['id'] == id);
          removeHighlightOverlay();
          markNeedsRebuild();
        },
      );
    }
    markNeedsRebuild();
  }

  void createHighlightOverlay(BuildContext itemContext, Map<String, dynamic> item) {
    // Remove the existing OverlayEntry.
    removeHighlightOverlay();

    assert(overlayEntry == null);

    animatingItem = item['id'];
    var obj = itemContext.findRenderObject() as RenderBox;
    var size = obj.size;
    var pos = obj.localToGlobal(Offset.zero);
    positionAnimation = TweenSequence([
      TweenSequenceItem(
          tween: RectTween(begin: Rect.fromLTWH(pos.dx, pos.dy, size.width, size.height), end: Rect.fromLTWH(pos.dx, 72, size.width, size.height)),
          weight: 1.0),
    ]).animate(CurvedAnimation(parent: overlayAnimationController, curve: Curves.decelerate));

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: overlayAnimationController,
                builder: (context, child) {
                  return Positioned(
                    left: positionAnimation.value?.left,
                    top: positionAnimation.value?.top,
                    height: positionAnimation.value?.height,
                    width: positionAnimation.value?.width,
                    child: Transform.scale(
                      scale: scaleAnimation.value,
                      child: child!,
                    ),
                  );
                },
                child: ListItem(
                  title: item['title'],
                  status: item['status'],
                  a: item['a'],
                  b: item['b'],
                  subText: item['subText'],
                  onClose: () => removeHighlightOverlay(),
                ),
              ),
            ],
          ),
        );
      },
    );

    // Add the OverlayEntry to the Overlay.
    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
  }

  // Remove the OverlayEntry.
  void removeHighlightOverlay() {
    overlayEntry?.remove();
    overlayEntry?.dispose();
    overlayEntry = null;
    animatingItem = null;
  }

  void remake() {
    var list = (first ? listA : listB).map(
      (map) {
        return {
          'id': map['id'],
          'title': map['title'],
          'status': lorem(paragraphs: 1, words: 1),
          'a': random.nextInt(11000),
          'b': random.nextInt(11000),
          'subText': lorem(paragraphs: 1, words: 20),
        };
      },
    );
    if (first) {
      listA = list.toList();
    } else {
      listB = list.toList();
    }
    markNeedsRebuild();
  }

  void flip() {
    first = !first;
    if (first) {
      transitionController.forward();
    } else {
      transitionController.reverse();
    }
    markNeedsRebuild();
  }
}

class _CartIcon extends StatelessWidget {
  final int items;

  const _CartIcon({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: kToolbarHeight,
      child: Stack(
        children: [
          Center(
            child: Icon(Icons.shopping_cart_outlined),
          ),
          AnimatedPositioned(
            duration: 1000.milliseconds,
            top: items > 0 ? 6 : -20,
            right: 12,
            curve: Curves.bounceOut,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colors.brandedOrange,
              ),
              padding: EdgeInsets.only(bottom: 1),
              child: Center(
                child: Text('$items', style: fonts.subText.textOnPrimary()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
