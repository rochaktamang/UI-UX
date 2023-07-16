import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/favCatModel.dart';
import '../services/firebase_service.dart';

class FavoriteCatRepository {
  CollectionReference<FavoriteCatModel> ref =
      FirebaseService.db.collection("favCat").withConverter<FavoriteCatModel>(
            //typecast garirakhnu naparos vanera banakoo reeeee
            fromFirestore: (snapshot, _) {
              return FavoriteCatModel.fromFirebaseSnapshot(snapshot);
            },
            toFirestore: (model, _) => model.toJson(),
          );

  Stream<QuerySnapshot<FavoriteCatModel>> getCat() {
    Stream<QuerySnapshot<FavoriteCatModel>> response = ref.snapshots();
    return response;
  }

  Future<FavoriteCatModel?> getOneCat(String id) async {
    DocumentSnapshot<FavoriteCatModel> response = await ref.doc(id).get();
    return response.data();
  }

  Future<FavoriteCatModel?> deleteCat(String id) async {
    await ref.doc(id).delete();
  }

  Future<bool> addCat(FavoriteCatModel data) async {
    await ref.add(data);
    return true;
  }

  Future<void> editCat(FavoriteCatModel data, String id) async {
    var response = await ref.doc(id).set(data);
    return response;
  }
}
