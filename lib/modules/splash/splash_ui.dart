
import 'package:base_app/modules/splash/splash_interactor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class SplashUi extends StatefulWidget {
  const SplashUi({
    super.key,
    required this.interactor,
  });
  final SplashInteractor interactor;

  @override
  State<SplashUi> createState() => _SplashUiState();
}

class _SplashUiState extends State<SplashUi> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.pushReplacement('/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            "assets/feria/splash.png",
            fit: BoxFit.cover,
          ),
        ),
        /*
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            color: splashColor,
          ),
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/logos/splash-logo.svg",
              ),
            ],
          ),
        ),
         */
      ],
    );
  }
}
