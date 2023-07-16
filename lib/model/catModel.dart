import 'package:cloud_firestore/cloud_firestore.dart';

class CatModel {
  String userId;
  String catId;
  String catName;
  String catDescription;
  int estimatedPrice;
  String breed;
  String color;
  String imageUrl;

  CatModel({
    required this.userId,
    required this.catId,
    required this.catName,
    required this.catDescription,
    required this.estimatedPrice,
    required this.breed,
    required this.color,
    required this.imageUrl,
  });

  factory CatModel.fromJson(Map<String, dynamic> json) => CatModel(
        userId: json["userId"],
        catId: json["catId"],
        catName: json["catName"],
        catDescription: json["catDescription"],
        estimatedPrice: json["estimatedPrice"],
        color: json["color"],
        breed: json["breed"],
        imageUrl: json["imageUrl"],
      );
  factory CatModel.fromFirebaseSnapshot(
          DocumentSnapshot<Map<String, dynamic>> json) =>
      CatModel(
        userId: json["userId"],
        catId: json["catId"],
        catName: json["catName"],
        catDescription: json["catDescription"],
        estimatedPrice: json["estimatedPrice"],
        color: json["color"],
        breed: json["breed"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "catId": catId,
        "catName": catName,
        "catDescription": catDescription,
        "estimatedPrice": estimatedPrice,
        "breed": breed,
        "color": color,
        "imageUrl": imageUrl,
      };
}
