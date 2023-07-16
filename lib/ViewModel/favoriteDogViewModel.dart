import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pawfect/model/favDogModel.dart';
import 'package:pawfect/repositories/FavoriteDogRepository.dart';

class FavoriteDogViewModel with ChangeNotifier {
  FavoriteDogRepository _favoriteDogRepository = FavoriteDogRepository();
  Stream<QuerySnapshot<FavoriteDogModel>>? _favdog;
  //_underscore rakheko variable aaru cls le use garna mildain a
  Stream<QuerySnapshot<FavoriteDogModel>>? get favdog => _favdog;

  Future<void> getDog() async {
    var response = _favoriteDogRepository.getDog();
    _favdog = response;
    notifyListeners();
  }

  Future<void> deleteDog(String id) async {
    await _favoriteDogRepository.deleteDog(id);
    notifyListeners();
  }
}
