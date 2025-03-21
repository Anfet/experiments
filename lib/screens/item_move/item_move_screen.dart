import 'package:experiments/screens/item_move/page_with_list.dart';
import 'package:flutter/material.dart';

class ItemMoveScreen extends StatefulWidget {
  const ItemMoveScreen({super.key});

  @override
  State<ItemMoveScreen> createState() => _ItemMoveScreenState();
}

class _ItemMoveScreenState extends State<ItemMoveScreen> {
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moving Items'),
      ),
      body: PageView(
        controller: pageController,
        children: [
          PageWithList(),
          PageWithList(),
          PageWithList(),
        ],
      ),
    );
  }
}
