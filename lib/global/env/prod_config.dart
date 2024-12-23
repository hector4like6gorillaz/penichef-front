import 'package:base_app/global/env/base/base_config.dart';

class ProdConfig implements BaseConfig {
  @override
  String get apiHost => "https://pokeapi.co/api/v2/";
}
