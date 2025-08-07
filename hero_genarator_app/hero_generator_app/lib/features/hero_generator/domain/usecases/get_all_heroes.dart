import '../entities/hero_entity.dart';
import '../repositories/hero_repository.dart';

class GetAllHeroes {
  final HeroRepository repository;
  GetAllHeroes(this.repository);

  Future<List<HeroEntity>> call() => repository.getAllHeroes();
}
