// services/digimon_api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/digimon_model.dart';

class DigimonService {
  final String baseUrl = 'https://digimon-api.vercel.app/api/digimon';

  Future<List<Digimon>> fetchDigimons() async {
    final url = Uri.parse(baseUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Digimon.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Digimons: ${response.statusCode}');
    }
  }

  Future<Digimon> fetchDigimonByName(String name) async {
    final url = Uri.parse('$baseUrl/name/$name');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        return Digimon.fromJson(data[0]); // Devuelve el primero encontrado
      } else {
        throw Exception('No Digimon found with name $name');
      }
    } else {
      throw Exception('Failed to fetch Digimon: ${response.statusCode}');
    }
  }
}
