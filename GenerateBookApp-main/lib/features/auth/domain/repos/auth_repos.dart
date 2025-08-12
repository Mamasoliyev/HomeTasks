import 'package:ai_book_summary_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepos {
  Future<UserEntity> register(String email, String password);
}
