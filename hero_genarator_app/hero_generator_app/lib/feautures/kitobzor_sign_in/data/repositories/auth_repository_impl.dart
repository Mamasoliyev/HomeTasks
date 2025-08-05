import 'package:kitobzor_app/feautures/kitobzor_sign_in/domain/entities/auth_response_entity.dart';

import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<AuthResponseEntity> signup(String phoneNumber, int otpCode) async {
    final data = await remoteDataSource.login(phoneNumber, otpCode);
    return AuthResponseEntity(
      accessToken: data['access_token'],
      refreshToken: data['refresh_token'],
    );
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }
}
