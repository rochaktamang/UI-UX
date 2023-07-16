// To parse this JSON data, do
//
//     final favoriteCatModel = favoriteCatModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

FavoriteCatModel favoriteCatModelFromJson(String str) =>
    FavoriteCatModel.fromJson(json.decode(str));

String favoriteCatModelToJson(FavoriteCatModel data) =>
    json.encode(data.toJson());

class FavoriteCatModel {
  FavoriteCatModel({
    required this.userId,
    required this.catId,
    required this.catgName,
    required this.imageUrl,
    required this.breed,
  });

  String userId;
  String catId;
  String catgName;
  String imageUrl;
  String breed;

  factory FavoriteCatModel.fromJson(Map<String, dynamic> json) =>
      FavoriteCatModel(
        userId: json["userId"],
        catId: json["catId"],
        catgName: json["catgName"],
        imageUrl: json["imageUrl"],
        breed: json["breed"],
      );
  factory FavoriteCatModel.fromFirebaseSnapshot(
          DocumentSnapshot<Map<String, dynamic>> json) =>
      FavoriteCatModel(
        userId: json["userId"],
        catId: json["catId"],
        catgName: json["catgName"],
        imageUrl: json["imageUrl"],
        breed: json["breed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "catId": catId,
        "catgName": catgName,
        "imageUrl": imageUrl,
        "breed": breed,
      };
}
