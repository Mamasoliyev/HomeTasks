import 'package:kitobzor_app/feautures/kitobzor_sign_in/domain/entities/auth_response_entity.dart';

import '../repositories/auth_repository.dart';

class SignupAuth {
  final AuthRepository repository;

  SignupAuth(this.repository);

  Future<AuthResponseEntity> call(String phoneNumber, int code) async {
    return await repository.signup(phoneNumber, code);
  }
}
