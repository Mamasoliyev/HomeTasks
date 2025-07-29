part of 'advice_cubit.dart';

abstract class AdviceState {}

class AdviceInitialState extends AdviceState {}

class AdviceLoadingState extends AdviceState {}

class AdviceLoadedState extends AdviceState {
  final AdviceModel advice;

  AdviceLoadedState(this.advice);
}

class AdviceErrorState extends AdviceState {
  final String message;

  AdviceErrorState(this.message);
}
