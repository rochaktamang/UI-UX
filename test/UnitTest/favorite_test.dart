import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pawfect/model/favDogModel.dart';
import 'package:pawfect/repositories/FavoriteDogRepository.dart';
import 'package:pawfect/services/firebase_service.dart';

void main() async {
  FirebaseService.db = FakeFirebaseFirestore();
  final FavoriteDogRepository favoriteDogRepository = FavoriteDogRepository();

  group('DogRepository', () {
    test('getDog should return a Stream<QuerySnapshot<FavoriteDogModel>>',
        () async {
      final stream = await favoriteDogRepository.getDog();
      expect(stream, isInstanceOf<Stream<QuerySnapshot<FavoriteDogModel>>>());
    });
  });

  group('DogRepository', () {
    test('editDog should update a document in Firestore', () async {
      final docId = 'testId';
      final data = FavoriteDogModel(
        dogName: 'Test Name',
        imageUrl: 'Test URL',
        breed: 'Test Breed',
        userId: '1',
        dogId: '1',
      );
      await favoriteDogRepository.editDog(data, docId);

      final snapshot =
          await FirebaseService.db.collection('favDog').doc(docId).get();
      final updatedData = FavoriteDogModel.fromJson(snapshot.data()!);

      expect(updatedData.dogName, equals(data.dogName));
      expect(updatedData.imageUrl, equals(data.imageUrl));
      expect(updatedData.breed, equals(data.breed));
    });
  });
}
