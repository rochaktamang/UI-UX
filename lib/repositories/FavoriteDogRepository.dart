import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/favDogModel.dart';
import '../services/firebase_service.dart';

class FavoriteDogRepository {
  CollectionReference<FavoriteDogModel> ref =
      FirebaseService.db.collection("favDog").withConverter<FavoriteDogModel>(
            //typecast garirakhnu naparos vanera banakoo reeeee
            fromFirestore: (snapshot, _) {
              return FavoriteDogModel.fromFirebaseSnapshot(snapshot);
            },
            toFirestore: (model, _) => model.toJson(),
          );

  Stream<QuerySnapshot<FavoriteDogModel>> getDog() {
    Stream<QuerySnapshot<FavoriteDogModel>> response = ref.snapshots();
    return response;
  }

  Future<FavoriteDogModel?> getOneDog(String id) async {
    DocumentSnapshot<FavoriteDogModel> response = await ref.doc(id).get();
    return response.data();
  }

  Future<FavoriteDogModel?> deleteDog(String id) async {
    await ref.doc(id).delete();
  }

  Future<bool> addDog(FavoriteDogModel data) async {
    await ref.add(data);
    return true;
  }

  Future<void> editDog(FavoriteDogModel data, String id) async {
    var response = await ref.doc(id).set(data);
    return response;
  }
}
