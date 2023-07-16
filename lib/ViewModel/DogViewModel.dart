import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pawfect/model/dogModel.dart';
import 'package:pawfect/repositories/DogRepository.dart';

class DogViewModel with ChangeNotifier {
  DogRepository _dogRepository = DogRepository();
  Stream<QuerySnapshot<DogModel>>? _dog;
  Stream<QuerySnapshot<DogModel>>? get dog => _dog;

  Future<void> getDog() async {
    var response = _dogRepository.getDogData();
    _dog = response;
    notifyListeners();
  }
}
