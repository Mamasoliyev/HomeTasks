import 'package:kitobzor_app/feautures/kitobzor_books/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<void> signIn(String phoneNumber, String password);
  Future<UserEntity> fetchCurrentUserData();
  Future<void> updateUserData(UserEntity user);
  Future<void> signOut();
  Future<bool> isSignedIn();
}