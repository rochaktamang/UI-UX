import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pawfect/model/favCatModel.dart';

import '../repositories/FavoriteCatRepository.dart';

class FavoriteCatViewModel with ChangeNotifier {
  FavoriteCatRepository _favoriteCatRepository = FavoriteCatRepository();
  Stream<QuerySnapshot<FavoriteCatModel>>? _favcat;
  //_underscore rakheko variable aaru cls le use garna mildain a
  Stream<QuerySnapshot<FavoriteCatModel>>? get favcat => _favcat;

  Future<void> getCat() async {
    var response = _favoriteCatRepository.getCat();
    _favcat = response;
    notifyListeners();
  }

  Future<void> deleteCat(String id) async {
    await _favoriteCatRepository.deleteCat(id);
    notifyListeners();
  }
}
