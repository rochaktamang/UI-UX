// To parse this JSON data, do
//
//     final favoriteDogModel = favoriteDogModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

FavoriteDogModel favoriteDogModelFromJson(String str) =>
    FavoriteDogModel.fromJson(json.decode(str));

String favoriteDogModelToJson(FavoriteDogModel data) =>
    json.encode(data.toJson());

class FavoriteDogModel {
  FavoriteDogModel({
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

  factory FavoriteDogModel.fromJson(Map<String, dynamic> json) =>
      FavoriteDogModel(
        userId: json["userId"],
        dogId: json["dogId"],
        dogName: json["dogName"],
        imageUrl: json["imageUrl"],
        breed: json["breed"],
      );
  factory FavoriteDogModel.fromFirebaseSnapshot(
          DocumentSnapshot<Map<String, dynamic>> json) =>
      FavoriteDogModel(
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
