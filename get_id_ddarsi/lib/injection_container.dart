import 'package:get_id_ddarsi/core/uscases/get_random_cat_image..dart';
import 'package:get_id_ddarsi/futures/random_cat/data/repos/cat_image_repos_impl.dart';
import 'package:get_id_ddarsi/futures/random_cat/data/source/cat_image_data_source.dart';
import 'package:get_id_ddarsi/futures/random_cat/domain/repos/cat_image_repos.dart';
import 'package:get_id_ddarsi/futures/random_cat/presintation/provider/cat_imagr_provider.dart';
import 'package:get_it/get_it.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // Provider
  sl.registerFactory(() => CatImageProvider(getRandomCatImage: sl()));

  // UseCase
  sl.registerLazySingleton(() => GetRandomCatImage(sl()));

  // Repository
  sl.registerLazySingleton<CatImageRepository>(
    () => CatImageRepositoryImpl(remoteDataSource: sl()),
  );

  // Data source
  sl.registerLazySingleton<CatImageRemoteDataSource>(
    () => CatImageRemoteDataSourceImpl(),
  );
}
