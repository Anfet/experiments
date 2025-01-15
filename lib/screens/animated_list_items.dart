import 'package:experiments/app_theme.dart';
import 'package:experiments/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commons/flutter_commons.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class AnimatedListItems extends StatefulWidget {
  const AnimatedListItems({super.key});

  @override
  State<AnimatedListItems> createState() => _AnimatedListItemsState();
}

class _AnimatedListItemsState extends State<AnimatedListItems> with MountedCheck {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          VSpacer(24),
          SizedBox(
            height: 40,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _Item(
                  title: lorem(words: 1, paragraphs: 1),
                  isSelected: random.nextBool(),
                );
              },
              separatorBuilder: (context, index) => HSpacer(12),
              itemCount: random.nextInt(10) + 1,
            ),
          ),
          VSpacer(24),
          ElevatedButton(onPressed: markNeedsRebuild, child: Text('rebuild')),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String title;
  final bool isSelected;

  const _Item({
    super.key,
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: 500.milliseconds,
      child: AnimatedContainer(
        duration: 500.milliseconds,
        constraints: BoxConstraints(minWidth: 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? theme.colors.accents : theme.colors.brandBlueAccent,
        ),
        padding: EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 6),
        alignment: Alignment.center,
        child: Text(title, style: fonts.mainText.w400().copyWith(color: isSelected ? theme.colors.brandBlue : theme.colors.white), maxLines: 1),
      ),
    );
  }
}
