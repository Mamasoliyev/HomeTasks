import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitobzor_app/feautures/kitobzor_sign_in/domain/usecases/signup_auth.dart';
import 'package:kitobzor_app/feautures/kitobzor_sign_in/presentation/cubit/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SignupAuth signupAuth;

  UserCubit({required this.signupAuth}) : super(UserInitial());

  Future<void> logout() async {
    try {
      emit(UserLoading());
      await signupAuth.logout(); // ✅ Repository orqali logout chaqiramiz
      emit(UserLoggedOut());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
