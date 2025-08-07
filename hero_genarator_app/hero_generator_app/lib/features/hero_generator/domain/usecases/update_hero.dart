import '../entities/hero_entity.dart';
import '../repositories/hero_repository.dart';

class UpdateHero {
  final HeroRepository repository;
  UpdateHero(this.repository);

  Future<void> call(HeroEntity hero) => repository.updateHero(hero);
}
