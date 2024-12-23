import 'package:base_app/modules/splash/splash_interactor.dart';
import 'package:base_app/modules/splash/splash_ui.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> implements SplashInteractor {
  @override
  Widget build(BuildContext context) {
    return SplashUi(
      interactor: this,
    );
  }
}
