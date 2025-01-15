import 'package:experiments/app/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_commons/flutter_commons.dart';

class AuthScreen extends StatefulWidget {
  final String phone;

  const AuthScreen({super.key, required this.phone});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: router.pop, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Center(
        child: Column(
          children: [
            Text('AUTH'),
            Text(widget.phone),
            VSpacer(32),
            ElevatedButton(onPressed: () => router.push('/auth/${widget.phone}/profile'), child: Text('To PROFILE')),
          ],
        ),
      ),
    );
  }
}
