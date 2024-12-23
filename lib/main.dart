import 'package:base_app/config/router.dart';
import 'package:base_app/global/env/environment.dart';
import 'package:base_app/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.DEV,
  );
  Environment().initConfig(environment);
  setupLocator();
  runApp(
    const ScreenUtilInit(
        // Tamaño base (puede ser iPhone 11 o cualquier otro)
        designSize: Size(390, 844),
        // Para ajustar los tamaños de texto automáticamente
        minTextAdapt: true,
        child: MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        fontFamily: "dm sans",
        textTheme: const TextTheme(),
        //colorScheme: const Color.fromRGBO(210, 160, 184, 1),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white, // El color base de tu esquema
          primary: Colors.red,
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Color.fromRGBO(245, 242, 235, 1),
          elevation: 1,
        ),
        appBarTheme: const AppBarTheme(
          color: Color.fromRGBO(245, 242, 235, 1),
          shadowColor: Colors.black,
          elevation: 1,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
              systemStatusBarContrastEnforced: true),
        ),
      ),
    );
  }
}
