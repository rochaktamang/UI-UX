import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';
import '../services/firebase_service.dart';

class AuthRepository {
  CollectionReference<UserModel> userRef =
      FirebaseService.db.collection("users").withConverter<UserModel>(
            fromFirestore: (snapshot, _) {
              return UserModel.fromFirebaseSnapshot(snapshot);
            },
            toFirestore: (model, _) => model.toJson(),
          );
  Future<UserCredential?> register(UserModel user) async {
    try {
      final response =
          await userRef.where("username", isEqualTo: user.username!).get();
      if (response.size != 0) {
        throw Exception("Username already exists");
      }
      UserCredential uc = await FirebaseService.firebaseAuth
          .createUserWithEmailAndPassword(
              email: user.email!, password: user.password!);

      user.userId = uc.user!.uid;
      user.fcmToken = "";
      // insert into firestore user table
      await userRef.add(user);
      return uc;
    } catch (err) {
      rethrow;
    }
  }

  Future<UserCredential> login(String email, String password) async {
    try {
      UserCredential uc = await FirebaseService.firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return uc;
    } catch (err) {
      rethrow;
    }
  }

  Future<UserModel> getUserDetail(String id) async {
    late UserModel userModel;
    try {
      final response = await userRef.where("user_id", isEqualTo: id).get();
      for(var data in response.docs) {
        userModel = data.data();
      }
      // UserModel userModel = UserModel(
      //   email: "test123@gmail.com",
      //   name: "Test",
      //   password: "123123123",
      //   phone: "98403555789",
      //   userId: "12093810982309812",
      //   username: "Test User"

      // );
      // var user = response.docs.single.data();
      // user.fcmToken = "";
      // await userRef.doc(user.userId).set(user);
      // return data;
      return userModel;
    } catch (err) {
      rethrow;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      var res = await FirebaseService.firebaseAuth
          .sendPasswordResetEmail(email: email);
      return true;
    } catch (err) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseService.firebaseAuth.signOut();
    } catch (err) {
      rethrow;
    }
  }
}
