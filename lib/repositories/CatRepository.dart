import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pawfect/model/catModel.dart';

import '../services/firebase_service.dart';

class CatRepository with ChangeNotifier {
  CollectionReference<CatModel> catRef =
      FirebaseService.db.collection("cats").withConverter<CatModel>(
            fromFirestore: (snapshot, _) {
              return CatModel.fromFirebaseSnapshot(snapshot);
            },
            toFirestore: (model, _) => model.toJson(),
          );

  Stream<QuerySnapshot<CatModel>> getCatData() {
    Stream<QuerySnapshot<CatModel>> response = catRef.snapshots();
    return response;
  }

  Future<DocumentSnapshot<CatModel>> getOneCat(String catId) async {
    try {
      final response = await catRef.doc(catId).get();
      if (!response.exists) {
        throw Exception("Cat doesnot exists");
      }
      return response;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<bool> addCat(CatModel data) async {
    await catRef.add(data);
    return true;
  }
}
