import 'package:get_it/get_it.dart';
import 'package:kitobzor_app/feautures/kitobzor_data/services/data_service.dart';
import 'package:kitobzor_app/feautures/kitobzor_sign_in/presentation/cubit/user_cubit.dart';
import 'core/network/dio_client.dart';
import 'core/network/token_storage.dart';

// Auth Feature
import 'package:kitobzor_app/feautures/kitobzor_sign_in/data/data_sources/auth_remote_data_source.dart';
import 'package:kitobzor_app/feautures/kitobzor_sign_in/data/repositories/auth_repository_impl.dart';
import 'package:kitobzor_app/feautures/kitobzor_sign_in/domain/repositories/auth_repository.dart';
import 'package:kitobzor_app/feautures/kitobzor_sign_in/domain/usecases/signup_auth.dart';
import 'package:kitobzor_app/feautures/kitobzor_sign_in/presentation/bloc/user_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // ✅ Core dependencies
  final tokenStorage = TokenStorage();
  sl.registerLazySingleton(() => tokenStorage);

  // ✅ DioClient
  sl.registerLazySingleton(() => DioClient('https://api.kitobzor.uz/api/v1/'));

  // ✅ Data Service
  sl.registerLazySingleton(() => DataService(sl<DioClient>()));

  // ✅ Auth Feature
  sl.registerLazySingleton(() => AuthRemoteDataSource(sl<DioClient>()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl<AuthRemoteDataSource>()));
  sl.registerLazySingleton(() => SignupAuth(sl<AuthRepository>()));
  sl.registerFactory(() => UserBloc(signupAuth: sl<SignupAuth>()));

  // Cubit
  sl.registerFactory(() => UserCubit(signupAuth: sl<SignupAuth>()));
  

}
