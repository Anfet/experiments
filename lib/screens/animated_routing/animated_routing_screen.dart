import 'package:flutter/material.dart';
import 'package:flutter_commons/flutter_commons.dart';

class AnimatedRoutingScreen extends StatefulWidget {
  const AnimatedRoutingScreen({super.key});

  @override
  State<AnimatedRoutingScreen> createState() => _AnimatedRoutingScreenState();
}

class _AnimatedRoutingScreenState extends State<AnimatedRoutingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Routing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 120,
              margin: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: randomSemiTransparentColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black26),
              ),
            ),
            VSpacer(12),
            SizedBox(
              height: 56,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 12,
                children: [
                  _IconButtonOutlined(icon: Icons.add, onPressed: () => null),
                  _IconButtonOutlined(icon: Icons.remove_circle_outline, onPressed: () => null),
                  _IconButtonOutlined(icon: Icons.copy_all, onPressed: () => null),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _IconButtonOutlined extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _IconButtonOutlined({
    super.key,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: InkButton(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black26.withValues(alpha: .1)),
          ),
          child: Center(
            child: Icon(icon, size: 28, color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
