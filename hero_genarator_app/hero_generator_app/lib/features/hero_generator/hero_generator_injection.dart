import 'package:get_it/get_it.dart';
import 'data/datasources/hero_remote_datasource.dart';
import 'data/datasources/image_remote_datasource.dart';
import 'data/repositories/hero_repository_impl.dart';
import 'data/repositories/image_repository_impl.dart';
import 'domain/repositories/hero_repository.dart';
import 'domain/repositories/image_repository.dart';
import 'domain/usecases/create_hero.dart';
import 'domain/usecases/delete_hero.dart';
import 'domain/usecases/generate_image.dart';
import 'domain/usecases/get_all_heroes.dart';
import 'domain/usecases/update_hero.dart';
import 'presentation/bloc/hero/hero_bloc.dart';
import 'presentation/bloc/image/image_bloc.dart';
import '../../core/network/dio_client.dart';

final sl = GetIt.instance;

Future<void> initHeroGenerator() async {
  // Dio Client
  sl.registerLazySingleton(() => DioClient());

  // DataSources
  sl.registerLazySingleton<HeroRemoteDataSource>(
    () => HeroRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<ImageRemoteDataSource>(
    () => ImageRemoteDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<HeroRepository>(() => HeroRepositoryImpl(sl()));
  sl.registerLazySingleton<ImageRepository>(() => ImageRepositoryImpl(sl()));

  // UseCases
  sl.registerLazySingleton(() => GetAllHeroes(sl()));
  sl.registerLazySingleton(() => CreateHero(sl()));
  sl.registerLazySingleton(() => UpdateHero(sl()));
  sl.registerLazySingleton(() => DeleteHero(sl()));
  sl.registerLazySingleton(() => GenerateImage(sl()));

  // Blocs
  sl.registerFactory(
    () => HeroBloc(
      getAllHeroes: sl(),
      createHero: sl(),
      updateHero: sl(),
      deleteHero: sl(),
    ),
  );
  sl.registerFactory(() => ImageBloc(sl()));
}
