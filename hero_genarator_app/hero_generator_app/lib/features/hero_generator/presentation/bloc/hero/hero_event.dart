import '../../../domain/entities/hero_entity.dart';

abstract class HeroEvent {}

class LoadHeroes extends HeroEvent {}

class CreateHeroEvent extends HeroEvent {
  final HeroEntity hero;
  CreateHeroEvent(this.hero);
}

class UpdateHeroEvent extends HeroEvent {
  final HeroEntity hero;
  UpdateHeroEvent(this.hero);
}

class DeleteHeroEvent extends HeroEvent {
  final String id;
  DeleteHeroEvent(this.id);
}
