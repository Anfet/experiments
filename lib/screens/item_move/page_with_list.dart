import 'package:flutter/material.dart';
import 'package:flutter_commons/flutter_commons.dart';

class PageWithList extends StatefulWidget {
  const PageWithList({super.key});

  @override
  State<PageWithList> createState() => _PageWithListState();
}

class _PageWithListState extends State<PageWithList> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(color: randomSemiTransparentColor);
  }
}
