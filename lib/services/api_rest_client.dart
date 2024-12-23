import 'dart:convert';

import 'package:base_app/global/env/environment.dart';
import 'package:base_app/utils/enums.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final storage = const FlutterSecureStorage();

  // Detectar si estamos en desarrollo o producción
  final String baseURL = Environment().config.apiHost;

  // BaseURL para v2 de la API
  // ignore: non_constant_identifier_names
  //String get baseURL_v2 => baseURL.replaceAll('v1', 'v2');

  // Obtener el token almacenado
  Future<String?> _getToken() async {
    return await storage.read(key: 'authToken');
  }

  // Headers básicos
  Map<String, String> _defaultHeaders({String token = ""}) {
    return {
      'Content-Type': 'application/json; charset=utf-8',
      if (token != "") 'Authorization': 'Bearer $token',
    };
  }

  // Servicio sin autenticación
  /*
  Future<http.Response> service(String endpoint) async {
    final url = Uri.parse('$baseURL$endpoint');
    final headers = _defaultHeaders();
    return await http.get(url, headers: {
      ...headers,
      //"key": "base64:Dn0qNlh3Dsoxa8bezXZLBvP829IYvvau2z/3H6AsBws="
    });
  }
   */

  // ignore: non_constant_identifier_names
  Future<http.Response> SERVICE({
    required Method method,
    required String endpoint,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    final url = Uri.parse('$baseURL$endpoint');
    final requestHeaders = headers ?? _defaultHeaders();

    // Dependiendo del método que recibas, realiza la solicitud HTTP correspondiente
    switch (method) {
      case Method.get:
        return await http.get(url, headers: requestHeaders);

      case Method.post:
        return await http.post(
          url,
          headers: requestHeaders,
          body: body != null
              ? jsonEncode(body)
              : null, // Si hay body, lo codificamos en JSON
        );

      case Method.patch:
        return await http.patch(
          url,
          headers: requestHeaders,
          body: body != null ? jsonEncode(body) : null,
        );

      case Method.put:
        return await http.put(
          url,
          headers: requestHeaders,
          body: body != null ? jsonEncode(body) : null,
        );

      case Method.delete:
        return await http.delete(url, headers: requestHeaders);

      default:
        throw UnsupportedError('El método $method no está soportado.');
    }
  }

  // Servicio con autenticación
  // ignore: non_constant_identifier_names
  Future<http.Response> AUTHSERVICE({
    required Method method,
    required String endpoint,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    final token = await _getToken();
    if (token == null) {
      // Redirige a login si el token no existe
      throw Exception('Usuario no autenticado');
    }
    final url = Uri.parse('$baseURL$endpoint');
    final requestHeaders = _defaultHeaders(token: token);

    // Dependiendo del método que recibas, realiza la solicitud HTTP correspondiente
    switch (method) {
      case Method.get:
        return await http.get(url, headers: requestHeaders);

      case Method.post:
        return await http.post(
          url,
          headers: requestHeaders,
          body: body != null
              ? jsonEncode(body)
              : null, // Si hay body, lo codificamos en JSON
        );

      case Method.patch:
        return await http.patch(
          url,
          headers: requestHeaders,
          body: body != null ? jsonEncode(body) : null,
        );

      case Method.put:
        return await http.put(
          url,
          headers: requestHeaders,
          body: body != null ? jsonEncode(body) : null,
        );

      case Method.delete:
        return await http.delete(url, headers: requestHeaders);

      default:
        throw UnsupportedError('El método $method no está soportado.');
    }
  }
}
