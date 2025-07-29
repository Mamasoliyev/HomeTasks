import 'dart:developer';

import 'package:bloc_lesson1/cubits/counter_cubit/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());

  // CUBITDA EVENT YO'Q

  // EMIT BU -> Stateni yangilab beradi.

  // increment counter
  void incrementCounter() {
    log(state.counter.toString());

    emit(CounterIncremented(counter: state.counter! + 1));
  }

  // decrement counter
  void decrementCounter() {
    emit(CounterDecremented(counter: state.counter! - 1));
  }
}
