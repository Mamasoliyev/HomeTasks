import 'package:equatable/equatable.dart';
import 'package:kitobzor_app/feautures/kitobzor_sign_in/domain/entities/auth_response_entity.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSignedUp extends UserState {
  final AuthResponseEntity tokens;

  const UserSignedUp({required this.tokens});

  @override
  List<Object?> get props => [tokens];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}
