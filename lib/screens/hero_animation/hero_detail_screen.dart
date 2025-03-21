import 'dart:async';

import 'package:experiments/app/navigation/app_router.dart';
import 'package:experiments/app_theme.dart';
import 'package:experiments/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_commons/flutter_commons.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'dart:ui' as ui;

class HeroDetailScreen extends StatefulWidget {
  final String asset;

  const HeroDetailScreen({super.key, required this.asset});

  @override
  State<HeroDetailScreen> createState() => _HeroDetailScreenState();
}

class _HeroDetailScreenState extends State<HeroDetailScreen> with MountedCheck {
  bool showDetails = false;
  Color backButtonColor = Colors.white;

  @override
  void initState() {
    checkImageAndStartAnimation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: backButtonColor == Colors.white ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        automaticallyImplyLeading: false,
        toolbarHeight: 150,
        flexibleSpace: FlexibleSpaceBar(
          background: Stack(
            children: [
              Positioned.fill(
                child: Hero(
                  tag: widget.asset,
                  transitionOnUserGestures: true,
                  child: Image.asset(widget.asset, fit: BoxFit.cover),
                ),
              ),
              Positioned(
                left: 0,
                top: context.viewPaddings.top,
                child: AnimatedOpacity(
                  duration: 300.milliseconds,
                  opacity: showDetails ? 1.0 : 0.0,
                  child: IconButton(
                    onPressed: router.pop,
                    icon: Icon(Icons.arrow_back, color: backButtonColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: showDetails
          ? RevealingWidget(
              duration: 2.seconds,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Some meal title', style: fonts.headline24),
                    VSpacer(4),
                    Text('1.0 kg', style: fonts.h2.textSecondary()),
                    VSpacer(8),
                    Text('from 3,445 R', style: fonts.headline28.textPrimary()),
                    VSpacer(12),
                    Text(lorem(paragraphs: random.nextInt(3) + 1, words: random.nextInt(50) + 20), style: fonts.smallText.textPrimary()),
                    VSpacer(32),
                    Text('Цвет', style: fonts.h2.textPrimary().bold()),
                    VSpacer(6),
                    Text(lorem(paragraphs: 1, words: random.nextInt(15) + 20), style: fonts.h16.textPrimary()),
                    VSpacer(20),
                    Text('Аромет', style: fonts.h2.textPrimary().bold()),
                    VSpacer(6),
                    Text(lorem(paragraphs: 1, words: random.nextInt(15) + 20), style: fonts.h16.textPrimary()),
                    VSpacer(20),
                    Text('Букет', style: fonts.h2.textPrimary().bold()),
                    VSpacer(6),
                    Text(lorem(paragraphs: 1, words: random.nextInt(15) + 20), style: fonts.h16.textPrimary()),
                    VSpacer(20),
                  ],
                ),
              ),
            )
          : EmptyBox(),
    );
  }

  Future checkImageAndStartAnimation() async {
    var byteData = (await rootBundle.loadStructuredBinaryData(widget.asset, (data) => data)).buffer.asUint8List();

    Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(byteData, (result) => completer.complete(result));
    ui.Image img = await completer.future;
    final pixelData = await img.toByteData();
    final buffer = pixelData!.buffer.asUint32List();
    var avgLuminance = 0.0;
    for (var y = img.height / 2 - 16; y <= img.height / 2 + 16; y++) {
      for (var x = img.width / 2 - 16; x <= img.width / 2 + 16; x++) {
        int centerIndex = (img.width * y + x).toInt();
        final centerPixel = buffer[centerIndex];
        var lum = Color(centerPixel).computeLuminance();
        avgLuminance += lum;
      }
    }
    avgLuminance /= (32 * 32);
    backButtonColor = avgLuminance >= .4 ? Colors.black : Colors.white;
    markNeedsRebuild();

    500.milliseconds.future.then(
      (value) {
        showDetails = true;
        markNeedsRebuild();
      },
    );
  }
}
