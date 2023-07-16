import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawfect/model/AdoptModel.dart';

import '../services/firebase_service.dart';

class AdoptionRepo {
  CollectionReference<AdoptionModel> ref =
      FirebaseService.db.collection("adopt").withConverter<AdoptionModel>(
            //typecast garirakhnu naparos vanera banakoo reeeee
            fromFirestore: (snapshot, _) {
              return AdoptionModel.fromFirebaseSnapshot(snapshot);
            },
            toFirestore: (model, _) => model.toJson(),
          );

  Stream<QuerySnapshot<AdoptionModel>> getAdopts() {
    Stream<QuerySnapshot<AdoptionModel>> response = ref.snapshots();
    return response;
  }

  Future<AdoptionModel?> getOneAdopt(String id) async {
    DocumentSnapshot<AdoptionModel> response = await ref.doc(id).get();
    return response.data();
  }

  Future<AdoptionModel?> deleteAdopt(String id) async {
    await ref.doc(id).delete();
  }

  Future<bool> addAdopt(AdoptionModel data) async {
    await ref.add(data);
    return true;
  }

  Future<void> editDog(AdoptionModel data, String id) async {
    var response = await ref.doc(id).set(data);
    return response;
  }
}
