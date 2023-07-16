import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pawfect/model/catModel.dart';
import 'package:pawfect/model/dogModel.dart';
import 'package:pawfect/repositories/CatRepository.dart';
import 'package:pawfect/repositories/DogRepository.dart';
import 'package:pawfect/services/firebase_service.dart';

void main() async {
  FirebaseService.db = FakeFirebaseFirestore();
  final DogRepository dogRepository = DogRepository();
  final CatRepository catRepository = CatRepository();
  test("add dog", () async {
    var response = await dogRepository.addDog(DogModel(
      dogName: "Test name",
      estimatedPrice: 5,
      imageUrl: "Test url",
      imagepath: "Test path",
      dogDescription: "xyz",
      dogId: "2",
      breed: "xyz",
      color: "abc",
    ));
    expect(response, true);
  });

  test("add cat", () async {
    var response = await catRepository.addCat(CatModel(
      catName: "Test name",
      estimatedPrice: 5,
      imageUrl: "Test url",
      catDescription: "xyz",
      catId: "2",
      breed: "xyz",
      color: "abc",
      userId: '1',
    ));
    expect(response, true);
  });
}
