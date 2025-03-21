import 'package:experiments/app/navigation/app_router.dart';
import 'package:experiments/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commons/flutter_commons.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class HeroMainScreen extends StatefulWidget {
  const HeroMainScreen({super.key});

  @override
  State<HeroMainScreen> createState() => _HeroMainScreenState();
}

class _HeroMainScreenState extends State<HeroMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero main'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            _ColumnItem(asset: Assets.heroFood1),
            _ColumnItem(asset: Assets.heroFood2),
            _ColumnItem(asset: Assets.heroFood3),
            _ColumnItem(asset: Assets.heroFood4),
          ],
        ),
      ),
    );
  }
}

class _ColumnItem extends StatelessWidget {
  final String asset;

  const _ColumnItem({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => router.toHeroDetail(asset: asset),
      borderRadius: BorderRadius.circular(16),
      radius: 16,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black26),
        ),
        height: 120,
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(16),
          child: Hero(
            tag: asset,
            transitionOnUserGestures: true,
            child: Image.asset(asset, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
