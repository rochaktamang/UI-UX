import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pawfect/model/dogModel.dart';

import '../services/firebase_service.dart';

class DogRepository with ChangeNotifier {
  CollectionReference<DogModel> dogRef =
      FirebaseService.db.collection("dogs").withConverter<DogModel>(
            fromFirestore: (snapshot, _) {
              return DogModel.fromFirebaseSnapshot(snapshot);
            },
            toFirestore: (model, _) => model.toJson(),
          );

  Stream<QuerySnapshot<DogModel>> getDogData() {
    Stream<QuerySnapshot<DogModel>> response = dogRef.snapshots();
    return response;
  }

  Future<DocumentSnapshot<DogModel>> getOneDog(String dogId) async {
    try {
      final response = await dogRef.doc(dogId).get();
      if (!response.exists) {
        throw Exception("Dog doesnot exists");
      }
      return response;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<bool> addDog(DogModel data) async {
    await dogRef.add(data);
    return true;
  }

  Future<bool?> addDogs({required DogModel dogModel}) async {
    try {
      final response = await dogRef.add(dogModel);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<List<QueryDocumentSnapshot<DogModel>>> getDogsFromList(
      List<String> dogIds) async {
    try {
      final response =
          await dogRef.where(FieldPath.documentId, whereIn: dogIds).get();
      var products = response.docs;
      return products;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<bool> removeDog(String dogId, String userId) async {
    try {
      final response = await dogRef.doc(dogId).get();
      if (response == null) {
        return false;
      }
      if (response.data()!.userId != userId) {
        return false;
      }
      await dogRef.doc(dogId).delete();
      return true;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  // Future<bool> removeDog(String dogId, String userId) async {
  //   try {
  //     final response = await dogRef.doc(dogId).get();
  //     if (response.data()!.userId != userId) {
  //       return false;
  //     }
  //     await dogRef.doc(dogId).delete();
  //     return true;
  //   } catch (err) {
  //     print(err);
  //     rethrow;
  //   }
  // }

  Future<List<QueryDocumentSnapshot<DogModel>>> getMyDogs(String userId) async {
    try {
      final response = await dogRef.where("user_id", isEqualTo: userId).get();
      var dogs = response.docs;
      return dogs;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<bool?> editDog({required DogModel dog, required String dogId}) async {
    try {
      final response = await dogRef.doc(dogId).set(dog);
      return true;
    } catch (err) {
      return false;
    }
  }
}
