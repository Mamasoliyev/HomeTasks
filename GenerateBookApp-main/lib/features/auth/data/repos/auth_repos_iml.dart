import 'package:ai_book_summary_app/features/auth/data/source/user_datasource.dart';
import 'package:ai_book_summary_app/features/auth/domain/entities/user_entity.dart';
import 'package:ai_book_summary_app/features/auth/domain/repos/auth_repos.dart';

class AuthReposIml extends AuthRepos {
  final FirebaseAuthDataSource dataSource;

  AuthReposIml({required this.dataSource});

  @override
  Future<UserEntity> register(String email, String password) {
    return dataSource.register(email, password);
  }
}
