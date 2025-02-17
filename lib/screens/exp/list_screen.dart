import 'package:experiments/app_theme.dart';
import 'package:experiments/app_typography.dart';
import 'package:experiments/screens/exp/country_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commons/flutter_commons.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> with MountedCheck {
  String? selected;
  String? nk;

  var countries = ['Россия', "Молддова", "США", "Беларусь", "Казахстан", "Узбекистан", "Эстония", "Украина"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Выберите гражданство', style: fonts.h1),
            ),
            VSpacer(16),
            //selected citizenship
            CollapsibleWidget(
              duration: 500.milliseconds,
              alignment: Alignment.topCenter,
              orientation: Axis.vertical,
              expanded: selected != null,
              clipBehavior: Clip.hardEdge,
              child: CountryTile(
                isSelected: true,
                name: selected ?? '',
                onTap: () {
                  selected = null;
                  nk = null;
                  markNeedsRebuild();
                },
              ),
              builder: (Animation<double> animation, Widget child) => Opacity(
                opacity: animation.value,
                child: child,
              ),
            ),
            //citizenships
            CollapsibleWidget(
              duration: 500.milliseconds,
              alignment: Alignment.topCenter,
              orientation: Axis.vertical,
              expanded: selected == null,
              clipBehavior: Clip.hardEdge,
              builder: (Animation<double> animation, Widget child) => Opacity(
                opacity: animation.value,
                child: child,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...countries.mapIndexed(
                    (i, item) => CountryTile(
                      isSelected: selected == item,
                      name: item,
                      onTap: () {
                        selected = item;
                        markNeedsRebuild();
                      },
                    ),
                  ),
                ],
              ),
            ),
            VSpacer(16),
            CollapsibleWidget(
              duration: 500.milliseconds,
              alignment: Alignment.topCenter,
              orientation: Axis.vertical,
              expanded: selected != null,
              clipBehavior: Clip.hardEdge,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Выберите страну', style: fonts.h1),
                  ),
                  CollapsibleWidget(
                    duration: 500.milliseconds,
                    alignment: Alignment.topCenter,
                    orientation: Axis.vertical,
                    expanded: nk != null,
                    clipBehavior: Clip.hardEdge,
                    child: CountryTile(
                      isSelected: true,
                      name: nk ?? '',
                      onTap: () {
                        nk = null;
                        markNeedsRebuild();
                      },
                    ),
                    builder: (Animation<double> animation, Widget child) => Opacity(
                      opacity: animation.value,
                      child: child,
                    ),
                  ),
                  CollapsibleWidget(
                    duration: 500.milliseconds,
                    alignment: Alignment.topCenter,
                    orientation: Axis.vertical,
                    expanded: nk == null,
                    clipBehavior: Clip.hardEdge,
                    builder: (Animation<double> animation, Widget child) => Opacity(
                      opacity: animation.value,
                      child: child,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...countries.mapIndexed(
                          (i, item) => CountryTile(
                            isSelected: nk == item,
                            name: item,
                            onTap: () {
                              nk = item;
                              markNeedsRebuild();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: ElevatedButton(onPressed: selected != null && nk != null ? () => null : null, child: Text('Далее')),
            ),
          ],
        ),
      ),
    );
  }
}
