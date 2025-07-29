import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_lesson1/data/models/advice_model.dart';
import 'package:bloc_lesson1/data/service/advice_service.dart';

part 'advice_state.dart';

class AdviceCubit extends Cubit<AdviceState> {
  AdviceCubit() : super(AdviceInitialState());

  void fetchAdvice() async {
    emit(AdviceLoadingState());
    try {
      final advice = await AdviceService.fetchData();
      emit(AdviceLoadedState(advice));
    } catch (e) {
      emit(AdviceErrorState("Xatolik yuz berdi: $e"));
    }
  }
}
