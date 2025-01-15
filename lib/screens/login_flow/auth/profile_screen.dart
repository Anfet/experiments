import 'package:experiments/app/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commons/flutter_commons.dart';

class ProfileScreen extends StatefulWidget {
  final String phone;

  const ProfileScreen({super.key, required this.phone});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text('PROFILE'),
            Text(widget.phone),
            VSpacer(32),
            ElevatedButton(onPressed: () => router.pop(), child: Text('To AUTH')),
          ],
        ),
      ),
    );
  }
}
