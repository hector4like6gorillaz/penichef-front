class Urls {
  static String getPokemonById({required int id}) {
    return 'pokemon/$id/';
  }

  static String getMewTwo = 'pokemon/150';

  static String inventary = 'inventary';
  static String subrecetas = 'subrecetas';

  static String getInventaryByPage({required String uri}) {
    return uri;
  }

  static String getSubrecetasByPage({required String uri}) {
    return uri;
  }

  static String calculateWithInventarySubreceta({required double finalWeight}) {
    return "subrecetas/calculateInventary?totalWeight=$finalWeight";
    //return "subrecetas/calculateInventary";
  }
}
