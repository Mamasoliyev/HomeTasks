import 'dart:developer';

import 'package:ai_book_summary_app/features/auth/domain/uscases/register_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../domain/entities/user_entity.dart';

class AuthController extends GetxController {
  final RegisterUser registerUser;
  AuthController(this.registerUser);

  final isLoading = false.obs;

  Future<UserEntity> register(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email yoki parol bo‘sh bo‘lmasligi kerak');
    }
    try {
      isLoading.value = true;
      log('Register boshlandi: email=$email');
      final user = await registerUser(email, password);
      log('Register muvaffaqiyatli: $user');
      return user;
    } on FirebaseAuthException catch (e) {
      log('Firebase xatosi: ${e.code} - ${e.message}');
      switch (e.code) {
        case 'weak-password':
          throw Exception('Parol juda qisqa, kamida 6 belgi bo‘lishi kerak');
        case 'email-already-in-use':
          throw Exception('Bu email allaqachon ishlatilgan');
        case 'invalid-email':
          throw Exception('Noto‘g‘ri email formati');
        default:
          throw Exception('Ro‘yxatdan o‘tishda xato: ${e.message}');
      }
    } on NoSuchMethodError catch (e) {
      log('NoSuchMethodError: $e');
      throw Exception('Foydalanuvchi ma’lumotlari noto‘g‘ri ishlatildi');
    } catch (e) {
      log('Umumiy xato: $e');
      throw Exception('Ro‘yxatdan o‘tishda xato: $e');
    } finally {
      isLoading.value = false;
    }
  }
}