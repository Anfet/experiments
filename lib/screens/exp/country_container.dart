import 'package:experiments/app_theme.dart';
import 'package:experiments/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commons/flutter_commons.dart';

class CountryContainer extends StatelessWidget {
  const CountryContainer({
    super.key,
    required this.isSelected,
    required this.text,
    this.subText = '',
    required this.image,
    required this.textWidth,
  });

  final String image;
  final String text;
  final String subText;
  final bool isSelected;
  final double textWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
            ),
            height: 24,
            width: 24,
            child: Image.asset(image ),
          ),
          HSpacer(12),
          Expanded(
            child: Text(text, style: fonts.h1start),
          ),
          HSpacer(16),
          _checkBox(),
        ],
      ),
    );
  }

  Widget _checkBox() {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          width: isSelected ? 6 : 1.5,
          color: isSelected ? theme.colors.activeElements : theme.colors.accents1,
        ),
      ),
    );
  }
}
