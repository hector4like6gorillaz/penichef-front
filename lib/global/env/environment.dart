import 'package:base_app/global/env/base/base_config.dart';
import 'package:base_app/global/env/dev_config.dart';
import 'package:base_app/global/env/prod_config.dart';

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  // ignore: constant_identifier_names
  static const String DEV = 'DEV';
  // ignore: constant_identifier_names
  static const String PROD = 'PROD';

  late BaseConfig config;

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.PROD:
        return ProdConfig();
      default:
        return DevConfig();
    }
  }
}
