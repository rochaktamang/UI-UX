import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pawfect/model/AdoptModel.dart';
import 'package:pawfect/repositories/adopt_repo.dart';

class AdoptionViewModel with ChangeNotifier {
  AdoptionRepo _adoptionRepo = AdoptionRepo();
  Stream<QuerySnapshot<AdoptionModel>>? _adoptdog;
  //_underscore rakheko variable aaru cls le use garna mildain a
  Stream<QuerySnapshot<AdoptionModel>>? get adoptDog => _adoptdog;

  Future<void> getAdopt() async {
    var response = _adoptionRepo.getAdopts();
    _adoptdog = response;
    notifyListeners();
  }

  Future<void> deleteAdopt(String id) async {
    await _adoptionRepo.deleteAdopt(id);
    notifyListeners();
  }
}
