import '../../../domain/entities/hero_entity.dart';

abstract class HeroState {}

class HeroInitial extends HeroState {}

class HeroLoading extends HeroState {}

class HeroLoaded extends HeroState {
  final List<HeroEntity> heroes;
  HeroLoaded(this.heroes);
}

class HeroError extends HeroState {
  final String message;
  HeroError(this.message);
}
