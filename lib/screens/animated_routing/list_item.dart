import 'package:experiments/app_theme.dart';
import 'package:experiments/app_typography.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commons/flutter_commons.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

typedef AsyncPositionedItemCallback = Future<Animation<double>?> Function(BuildContext? context, Widget self);

class ListItem extends StatelessWidget {
  final bool isPlaceholder;

  final String title;
  final String status;
  final int a;
  final int b;

  final String subText;
  final VoidCallback? onClose;
  final AsyncValueSetter<BuildContext>? onTap;
  final ValueSetter<BuildContext>? contextProvider;

  final Size size;

  const ListItem({
    super.key,
    required this.title,
    required this.status,
    required this.a,
    required this.b,
    required this.subText,
    this.onClose,
    this.onTap,
    this.contextProvider,
    this.isPlaceholder = false,
    this.size = Size.zero,
  });

  @override
  Widget build(BuildContext context) {
    contextProvider?.call(context);
    return AnimatedSize(
      duration: 1.seconds,
      child: isPlaceholder
          ? SizedBox.fromSize(size: size)
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26.withValues(alpha: .1), blurStyle: BlurStyle.solid, offset: Offset(0, 0), blurRadius: 2, spreadRadius: 2)
                ],
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 40.0),
                            child: Text(title, style: fonts.h2),
                          ),
                          VSpacer(12),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.black12,
                              ),
                              child: Text(status, style: fonts.subText),
                            ),
                          ),
                          VSpacer(16),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(lorem(paragraphs: 1, words: 2), textAlign: TextAlign.center, style: fonts.smallText),
                                    Text('${a}', textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(lorem(paragraphs: 1, words: 2), textAlign: TextAlign.center, style: fonts.smallText),
                                    Text('${b}', textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          VSpacer(12),
                          Text(subText, style: fonts.smallText.textSecondary()),
                          VSpacer(12),
                          Row(
                            spacing: 12,
                            children: [
                              Expanded(child: ElevatedButton(onPressed: () => onTap?.call(context), child: Text(lorem(paragraphs: 1, words: 2)))),
                              ElevatedButton(onPressed: () => onTap?.call(context), child: Text('+')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (onClose != null)
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(onPressed: () => onClose?.call(), icon: Icon(Icons.close)),
                    ),
                ],
              ),
            ),
    );
  }
}
