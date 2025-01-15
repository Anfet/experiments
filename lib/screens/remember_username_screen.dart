import 'package:experiments/app/navigation/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_commons/flutter_commons.dart';
import 'package:local_auth/local_auth.dart';

class RememberUsernameScreen extends StatefulWidget {
  const RememberUsernameScreen({super.key});

  @override
  State<RememberUsernameScreen> createState() => _RememberUsernameScreenState();
}

class _RememberUsernameScreenState extends State<RememberUsernameScreen> with WidgetsBindingObserver   {
  final FocusNode usernameNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  final LocalAuthentication auth = LocalAuthentication();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  AppLifecycleState state = AppLifecycleState.resumed;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    this.state = state;
  }

  @override
  void initState() {
    super.initState();
    TextInput.ensureInitialized();
    WidgetsBinding.instance.addObserver(this);

    passwordNode.addListener(() async {
      if (state == AppLifecycleState.inactive) {
        passwordNode.requestFocus();
      };
    });

    usernameNode.addListener(() async {
      if (state == AppLifecycleState.inactive) {
        usernameNode.requestFocus();
      };
    });
  }

  @override
  void dispose() {
    passwordNode.dispose();
    usernameNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remember password'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: AutofillGroup(
            onDisposeAction: AutofillContextAction.cancel,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CupertinoTextField(
                  focusNode: usernameNode,
                  keyboardType: TextInputType.text,
                  autofillHints: [AutofillHints.username],
                  controller: userController,
                  // decoration: InputDecoration(
                  //   // border: OutlineInputBorder(),
                  //   hintText: 'phone',
                  // ),
                  onSubmitted: (value) {},
                ),
                VSpacer(12),
                CupertinoTextField(
                  focusNode: passwordNode,
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: false,
                  autofillHints: [AutofillHints.password],
                  // decoration: InputDecoration(
                  //   border: OutlineInputBorder(),
                    // hintText: 'password',
                  // ),
                  onSubmitted: (value) {},
                ),
                Spacer(),

                ElevatedButton(
                  onPressed: () {
                    bioLogin();
                  },
                  child: Text('Bio auth'),
                ),
                VSpacer(24),
                ElevatedButton(
                  onPressed: () {

                    TextInput.finishAutofillContext();
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Проверка на доступность биометрического входа
  Future<bool> checkAvailable() async {
    final bool canAuthWithBiometric = await auth.canCheckBiometrics;
    return canAuthWithBiometric || await auth.isDeviceSupported();
  }

  // Получаем список доступных методов для входа
  Future<List<BiometricType>> getAvailableBiometrics() async {
    bool isAvailable = await checkAvailable();
    if (!isAvailable) {
      return [];
    }

    return await auth.getAvailableBiometrics();
  }

  // Вход по биометрическому методу
  Future<bool> bioLogin() async {
    try {
      return await auth.authenticate(
        localizedReason: 'Check in',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
    } catch (ex, stack) {
      return false;
    }
  }

}
