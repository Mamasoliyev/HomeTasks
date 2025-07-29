// ignore_for_file: public_member_api_docs, sort_constructors_first
// // single state
// class CounterState {
//   int counter;
//   String? errorMessage;
//   CounterState({required this.counter, this.errorMessage});
// }

abstract class CounterState {
  int? counter;
  CounterState({this.counter});
}

// initial
class CounterInitial extends CounterState {
  CounterInitial() : super(counter: 0);
}

// error
class CounterError extends CounterState {}

// incremented
class CounterIncremented extends CounterState {
  CounterIncremented({required int counter}) : super(counter: counter);
}

// decremented
class CounterDecremented extends CounterState {
  CounterDecremented({required int counter}) : super(counter: counter);
}
