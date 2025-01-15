import 'package:experiments/app/navigation/app_router.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () => router.to('/login/registration'), child: Text('To Registration')),
            ElevatedButton(onPressed: () => router.to('/sms'), child: Text('To SMS')),
            ElevatedButton(onPressed: () => router.push('/auth/69462250'), child: Text('To auth')),
          ],
        ),
      ),
    );
  }
}
