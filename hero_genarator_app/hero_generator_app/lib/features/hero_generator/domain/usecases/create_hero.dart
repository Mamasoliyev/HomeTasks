import '../entities/hero_entity.dart';
import '../repositories/hero_repository.dart';

class CreateHero {
  final HeroRepository repository;
  CreateHero(this.repository);

  Future<void> call(HeroEntity hero) => repository.createHero(hero);
}
