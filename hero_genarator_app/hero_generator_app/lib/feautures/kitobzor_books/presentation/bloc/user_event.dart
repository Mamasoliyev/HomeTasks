import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class SignupEvent extends UserEvent {
  final String phoneNumber;
  final int otpCode;

  const SignupEvent(this.phoneNumber, this.otpCode);

  @override
  List<Object?> get props => [phoneNumber, otpCode];
}
