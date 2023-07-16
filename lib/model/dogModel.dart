import 'package:cloud_firestore/cloud_firestore.dart';

class DogModel {
  String? userId;
  String? dogId;
  String? dogName;
  String? dogDescription;
  int? estimatedPrice;
  String? breed;
  String? color;
  String? imageUrl;
  String? imagepath;

  DogModel({
    this.userId,
    this.dogId,
    this.dogName,
    this.dogDescription,
    this.estimatedPrice,
    this.breed,
    this.color,
    this.imageUrl,
    this.imagepath,
  });

  factory DogModel.fromJson(Map<String, dynamic> json) => DogModel(
        userId: json["userId"],
        dogId: json["dogId"],
        dogName: json["dogName"],
        dogDescription: json["dogDescription"],
        estimatedPrice: json["estimatedPrice"],
        color: json["color"],
        breed: json["breed"],
        imageUrl: json["imageUrl"],
        imagepath: json["imagepath"],
      );
  factory DogModel.fromFirebaseSnapshot(
          DocumentSnapshot<Map<String, dynamic>> json) =>
      DogModel(
          userId: json["userId"],
          dogId: json["dogId"],
          dogName: json["dogName"],
          dogDescription: json["dogDescription"],
          estimatedPrice: json["estimatedPrice"],
          breed: json["breed"],
          color: json["color"],
          imageUrl: json["imageUrl"],
          imagepath: json["imagepath"]);

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "dogId": dogId,
        "dogName": dogName,
        "dogDescription": dogDescription,
        "estimatedPrice": estimatedPrice,
        "breed": breed,
        "color": color,
        "imageUrl": imageUrl,
        "imagepath": imagepath
      };
}
