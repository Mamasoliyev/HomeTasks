import 'dart:developer';

import 'package:ai_book_summary_app/features/auth/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterUser {
  Future<UserEntity> call(String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user == null) {
        throw Exception('Foydalanuvchi yaratilmadi');
      }
      return UserEntity(
        uid: user.uid, // `user['uid']` o‘rniga `user.uid`
        email: user.email ?? '', // `user['email']` o‘rniga `user.email`
      );
    } catch (e) {
      log('RegisterUser xatosi: $e');
      rethrow; // Xatolikni yuqoriga tashlash
    }
  }
}
