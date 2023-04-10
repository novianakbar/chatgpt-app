import 'package:flutter/material.dart';
import 'package:ChatGPT/models/models_model.dart';
import 'package:ChatGPT/services/api_service.dart';

class ModelsProvider with ChangeNotifier {
  String currentModel = "gpt-3.5-turbo-0301";
  bool hasMemory = false;

  String get getCurrentModel {
    return currentModel;
  }

  void setMemoryEnabled(bool enabled) {
    hasMemory = enabled;
    notifyListeners();
  }

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<ModelsModel> modelsList = [];

  List<ModelsModel> get getModelsList => modelsList;

  Future<List<ModelsModel>> getAllModels() async {
    modelsList = await ApiService.getModels();
    return modelsList;
  }
}
