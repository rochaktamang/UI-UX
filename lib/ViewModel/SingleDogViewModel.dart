import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pawfect/model/dogModel.dart';
import 'package:pawfect/repositories/DogRepository.dart';

class SingleDogViewModel with ChangeNotifier {
  DogRepository _dogRepository = DogRepository();
  DogModel? _dog = DogModel();
  DogModel? get dog => _dog;

  Future<void> getDogs(String dogId) async {
    _dog = DogModel();
    notifyListeners();
    try {
      var response = await _dogRepository.getOneDog(dogId);
      _dog = response.data();
      notifyListeners();
    } catch (e) {
      _dog = null;
      notifyListeners();
    }
  }

  Future<void> addProduct(DogModel dog) async {
    try {
      var response = await _dogRepository.addDogs(dogModel: dog);
    } catch (e) {
      notifyListeners();
    }
  }
}
