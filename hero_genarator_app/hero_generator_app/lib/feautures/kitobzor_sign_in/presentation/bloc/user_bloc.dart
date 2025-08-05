
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitobzor_app/core/network/token_storage.dart';
import 'package:kitobzor_app/feautures/kitobzor_sign_in/domain/entities/auth_response_entity.dart';
import 'package:kitobzor_app/feautures/kitobzor_sign_in/domain/usecases/signup_auth.dart';
import 'package:kitobzor_app/injection_container.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final SignupAuth signupAuth;

  UserBloc({required this.signupAuth}) : super(UserInitial()) {
    on<SignupEvent>(_onSignup);
  }

  Future<void> _onSignup(SignupEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final tokens = await signupAuth.call(event.phoneNumber, event.otpCode);
      // log(tokens.toString());
      await sl<TokenStorage>().saveTokens(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      );
      emit(
        UserSignedUp(
          tokens: AuthResponseEntity(
            accessToken: tokens.accessToken,
            refreshToken: tokens.refreshToken,
          ),
        ),
      );
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
