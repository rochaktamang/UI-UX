import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pawfect/repositories/auth_repositories.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class User {
  final int id;
  final String name;

  User({required this.id, required this.name});
}

void main() {
  group('logout', () {
    test('sets _user to null and calls notifyListeners after logout', () async {
      final mockAuthRepository = MockAuthRepository();
      final user = User(id: 1, name: 'John');
      final myViewModel =
          MyViewModel(authRepository: mockAuthRepository, user: user);

      when(mockAuthRepository.logout()).thenAnswer((_) async => null);

      expect(myViewModel.user, equals(user));

      await myViewModel.logout();

      expect(myViewModel.user, isNull);
      verify(myViewModel.notifyListeners()).called(1);
    });

    test('rethrows error thrown by AuthRepository', () async {
      final mockAuthRepository = MockAuthRepository();
      final myViewModel = MyViewModel(authRepository: mockAuthRepository);

      final error = Exception('Logout error');

      when(mockAuthRepository.logout()).thenThrow(error);

      expect(() => myViewModel.logout(), throwsA(error));
    });
  });
}

class MyViewModel with ChangeNotifier {
  MyViewModel({required this.authRepository, this.user});

  final AuthRepository authRepository;
  User? user;

  Future<void> logout() async {
    try {
      await authRepository.logout();
      user = null;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
