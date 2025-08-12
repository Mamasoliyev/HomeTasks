import 'package:ai_book_summary_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.uid,
    required super.email,
  });

  factory UserModel.fromFromFirebaseUser(dynamic user) {
    return UserModel(
      uid: user['uid'],
      email: user['email'],
    );
  }
}
