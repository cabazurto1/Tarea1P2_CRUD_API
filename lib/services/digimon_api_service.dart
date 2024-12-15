import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/digimon_model.dart';

class DigimonService {
  // Definir la URL base de la API
  final String baseUrl = 'https://digimon-api.vercel.app/api/digimon';

  // Método para obtener una lista de Digimons con paginación
  Future<List<Digimon>> fetchDigimons({int page = 1, int pageSize = 10}) async {
    // Crear la URL con los parámetros de paginación
    final url = Uri.parse('$baseUrl?page=$page&pageSize=$pageSize');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('API Response: $data'); // Log para depuración de la respuesta
      return (data as List).map((json) => Digimon.fromJson(json)).toList();
    } else {
      // En caso de error, se lanza una excepción
      throw Exception('Failed to load Digimons: ${response.statusCode}');
    }
  }

  // Método para obtener un Digimon por su ID
  Future<Digimon> fetchDigimonById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return Digimon.fromJson(jsonDecode(response.body));
    } else {
      // En caso de error, se lanza una excepción
      throw Exception('Failed to fetch Digimon: ${response.statusCode}');
    }
  }

  // Método para buscar Digimons por nombre
  Future<List<Digimon>> searchDigimonsByName(String name) async {
    final response = await http.get(Uri.parse('$baseUrl?name=$name&exact=false'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Verificar que el campo 'content' existe antes de intentar acceder a él
      if (data is Map && data['content'] != null) {
        return (data['content'] as List).map((e) => Digimon.fromJson(e)).toList();
      } else {
        return []; // Si no hay contenido, se devuelve una lista vacía
      }
    } else {
      // En caso de error, se lanza una excepción
      throw Exception('Failed to search Digimons: ${response.statusCode}');
    }
  }
}
