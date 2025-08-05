abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoggedOut extends UserState {}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}
