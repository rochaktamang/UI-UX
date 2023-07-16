// To parse this JSON data, do
//
//     final favoriteDogModel = favoriteDogModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

AdoptionModel adoptionModelFromJson(String str) =>
    AdoptionModel.fromJson(json.decode(str));

String adoptionModelToJson(AdoptionModel data) => json.encode(data.toJson());

class AdoptionModel {
  AdoptionModel({
    required this.userId,
    required this.dogId,
    required this.dogName,
    required this.imageUrl,
    required this.breed,
  });

  String userId;
  String dogId;
  String dogName;
  String imageUrl;
  String breed;

  factory AdoptionModel.fromJson(Map<String, dynamic> json) => AdoptionModel(
        userId: json["userId"],
        dogId: json["dogId"],
        dogName: json["dogName"],
        imageUrl: json["imageUrl"],
        breed: json["breed"],
      );
  factory AdoptionModel.fromFirebaseSnapshot(
          DocumentSnapshot<Map<String, dynamic>> json) =>
      AdoptionModel(
        userId: json["userId"],
        dogId: json["dogId"],
        dogName: json["dogName"],
        imageUrl: json["imageUrl"],
        breed: json["breed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "dogId": dogId,
        "dogName": dogName,
        "imageUrl": imageUrl,
        "breed": breed,
      };
}
