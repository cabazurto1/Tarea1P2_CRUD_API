// controller/digimon_controller.dart
import 'package:flutter/foundation.dart';
import '../model/digimon_model.dart';
import '../services/digimon_api_service.dart';

class DigimonController with ChangeNotifier {
  final DigimonService _digimonService = DigimonService();
  List<Digimon> _digimons = [];

  List<Digimon> get digimons => _digimons;

  Future<void> loadDigimons() async {
    try {
      final fetchedDigimons = await _digimonService.fetchDigimons();
      _digimons = fetchedDigimons;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void addDigimon(Digimon digimon) {
    _digimons.add(digimon);
    notifyListeners();
  }

  void updateDigimon(int index, Digimon updatedDigimon) {
    if (index >= 0 && index < _digimons.length) {
      _digimons[index] = updatedDigimon;
      notifyListeners();
    }
  }

  void deleteDigimon(int index) {
    if (index >= 0 && index < _digimons.length) {
      _digimons.removeAt(index);
      notifyListeners();
    }
  }
}
