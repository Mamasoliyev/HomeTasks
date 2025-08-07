import 'package:flutter_bloc/flutter_bloc.dart';
import 'hero_event.dart';
import 'hero_state.dart';
import '../../../domain/usecases/get_all_heroes.dart';
import '../../../domain/usecases/create_hero.dart';
import '../../../domain/usecases/update_hero.dart';
import '../../../domain/usecases/delete_hero.dart';

class HeroBloc extends Bloc<HeroEvent, HeroState> {
  final GetAllHeroes getAllHeroes;
  final CreateHero createHero;
  final UpdateHero updateHero;
  final DeleteHero deleteHero;

  HeroBloc({
    required this.getAllHeroes,
    required this.createHero,
    required this.updateHero,
    required this.deleteHero,
  }) : super(HeroInitial()) {
    on<LoadHeroes>((event, emit) async {
      emit(HeroLoading());
      try {
        final heroes = await getAllHeroes();
        emit(HeroLoaded(heroes));
      } catch (e) {
        emit(HeroError(e.toString()));
      }
    });

    on<CreateHeroEvent>((event, emit) async {
      try {
        await createHero(event.hero);
        add(LoadHeroes());
      } catch (e) {
        emit(HeroError(e.toString()));
      }
    });

    on<UpdateHeroEvent>((event, emit) async {
      try {
        await updateHero(event.hero);
        add(LoadHeroes());
      } catch (e) {
        emit(HeroError(e.toString()));
      }
    });

    on<DeleteHeroEvent>((event, emit) async {
      try {
        await deleteHero(event.id);
        add(LoadHeroes());
      } catch (e) {
        emit(HeroError(e.toString()));
      }
    });
  }
}
