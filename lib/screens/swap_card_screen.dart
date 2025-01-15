import 'package:experiments/app/navigation/app_router.dart';
import 'package:experiments/widgets/flip_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_commons/flutter_commons.dart';

class SwapCardScreen extends StatefulWidget {
  SwapCardScreen({super.key});

  @override
  State<SwapCardScreen> createState() => _SwapCardScreenState();
}

class _SwapCardScreenState extends State<SwapCardScreen> {
  static final List<Color> tsGradient = [const Color(0xff9777FF), const Color(0xff6E43FA)];

  var isFront = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    var overlay = SystemUiOverlayStyle(
      statusBarColor: Colors.white.withOpacity(0.02),
      systemNavigationBarColor: Colors.white.withOpacity(0.02),
      systemNavigationBarDividerColor: Colors.white.withOpacity(0.02),
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(overlay);

    return Scaffold(
      backgroundColor: Colors.black26,
      // resizeToAvoidBottomInset: false,
      // extendBodyBehindAppBar: true,
      // extendBody: true,
      // appBar: AppBar(
      //   toolbarHeight: 0.1,
      //   systemOverlayStyle: overlay,
      //   backgroundColor: Colors.transparent,
      // ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            isFront = !isFront;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 200,
                child: AnimatedFlip(
                  backgroundColor: Colors.white,
                  child: isFront ? cardFront(context) : cardBack(context),
                  duration: Duration(seconds: 5),
                ),
              ),
              Spacer(),
              ElevatedButton(onPressed: router.navigateToA, child: Text('GOTO')),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardFront(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Card(
        color: Colors.white,
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: tsGradient,
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 14),
                  blurRadius: 50,
                  color: Colors.white10,
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Some promo"),
                const Spacer(),
                Text("You earned", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white54)),
                const VSpacer(4),
                Text("10000 coins", style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white)),
                const VSpacer(4),
                Text('Эту сумму можно вывести\nпосле завершения акции',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardBack(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   colors: tsGradient,
              //   begin: Alignment.topRight,
              //   end: Alignment.bottomLeft,
              // ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 14),
                  blurRadius: 50,
                  color: Colors.white10,
                )
              ]),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Lorem lipsum", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black54)),
                VSpacer(8),
                Text(
                    "Nulla aliquet pulvinar nulla, in accumsan ligula cursus a. Mauris gravida ultricies augue eu euismod. Sed vel dictum urna. Etiam vel feugiat mauris. Suspendisse mattis molestie magna ac rutrum. Maecenas mi massa, euismod nec mi in, aliquam pretium lectus. Donec vehicula fringilla sapien efficitur ultricies. Cras in quam quis purus congue sollicitudin a a nisi. Cras efficitur, sem a ullamcorper facilisis, urna nulla cursus mi, non lobortis odio mauris ac sem. Duis venenatis convallis ullamcorper. Curabitur non urna porta quam varius varius a eget nibh.",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
