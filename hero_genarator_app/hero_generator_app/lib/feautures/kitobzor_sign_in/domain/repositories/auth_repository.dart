import 'package:kitobzor_app/feautures/kitobzor_sign_in/domain/entities/auth_response_entity.dart';

abstract class AuthRepository {
  //signup method to handle user registration
  Future<AuthResponseEntity> signup(String phoneNumber, int otpCode);

  // logout method to handle user logout
  Future<void> logout();

}
