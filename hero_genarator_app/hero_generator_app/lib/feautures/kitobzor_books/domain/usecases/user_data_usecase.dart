import 'package:kitobzor_app/feautures/kitobzor_books/domain/entities/user_entity.dart';
import 'package:kitobzor_app/feautures/kitobzor_books/domain/repositories/user_respository.dart';

class UserDataUsecase {
  final UserRepository _userRepository;

  UserDataUsecase(this._userRepository);

  Future<void> signIn(String phoneNumber, String password) {
    return _userRepository.signIn(phoneNumber, password);
  }

  Future<UserEntity> fetchCurrentUserData() {
    return _userRepository.fetchCurrentUserData();
  }

  Future<void> updateUserData(UserEntity user) {
    return _userRepository.updateUserData(user);
  }

  Future<void> signOut() {
    return _userRepository.signOut();
  }

  Future<bool> isSignedIn() {
    return _userRepository.isSignedIn();
  }
}