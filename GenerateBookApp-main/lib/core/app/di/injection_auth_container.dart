// lib/injection_container.dart

import 'package:ai_book_summary_app/features/auth/data/repos/auth_repos_iml.dart';
import 'package:ai_book_summary_app/features/auth/data/source/user_datasource.dart';
import 'package:ai_book_summary_app/features/auth/domain/repos/auth_repos.dart';
import 'package:ai_book_summary_app/features/auth/domain/uscases/register_user.dart';
import 'package:ai_book_summary_app/features/auth/presintitation/controller/auht_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // Firebase instance
  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Data source
  locator.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSourceImpl(firebaseAuth: locator()),
  );

  // Repository
  locator.registerLazySingleton<AuthRepos>(
    () => AuthReposIml(dataSource: locator()),
  );

  // Use cases
  locator.registerLazySingleton<RegisterUser>(() => RegisterUser());

  // Controller
  locator.registerFactory<AuthController>(() => AuthController(locator()));
}
