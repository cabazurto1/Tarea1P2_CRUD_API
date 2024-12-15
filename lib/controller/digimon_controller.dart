import 'package:flutter/foundation.dart';
import '../model/digimon_model.dart';
import '../services/digimon_api_service.dart';

class DigimonController with ChangeNotifier {
  final DigimonService _digimonService = DigimonService();
  List<Digimon> _digimons = [];
  int _page = 1;

  List<Digimon> get digimons => _digimons;

  Future<void> fetchDigimons() async {
    try {
      final fetchedDigimons = await _digimonService.fetchDigimons(page: _page);
      _digimons.addAll(fetchedDigimons);
      notifyListeners();
    } catch (e) {
      // Manejo de errores
    }
  }

  void addDigimon(Digimon digimon) {
    _digimons.add(digimon);
    notifyListeners();
  }
}
