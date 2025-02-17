import 'package:experiments/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commons/flutter_commons.dart';

import 'country_container.dart';

class CountryTile extends StatelessWidget {
  final String name;
  final VoidCallback? onTap;
  final bool isSelected;

  const CountryTile({
    super.key,
    required this.name,
    this.onTap,
    required this.isSelected,
  });

  static const images = [
    Assets.beginningFlag000,
    Assets.beginningFlag031,
    Assets.beginningFlag144,
    Assets.beginningFlag231,
    Assets.beginningFlag356,
    Assets.beginningFlag398,
    Assets.beginningFlag417,
    Assets.beginningFlag498,
  ];

  @override
  Widget build(BuildContext context) {
    return InkButton(
      onTap: onTap,
      child: CountryContainer(
        textWidth: MediaQuery.of(context).size.width,
        image: images.randomElement,
        text: name,
        isSelected: isSelected,
      ),
    );
  }
}
