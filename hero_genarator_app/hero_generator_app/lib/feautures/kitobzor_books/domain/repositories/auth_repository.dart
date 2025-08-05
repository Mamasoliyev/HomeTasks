import 'package:kitobzor_app/feautures/kitobzor_sign_in/domain/entities/auth_response_entity.dart';

abstract class AuthRepository {
  Future<AuthResponseEntity> signup(String phoneNumber, int otpCode);
  Future<void> updateProfile(
    String firstName,
    String lastName,
    String phoneNumber,
  );
}
