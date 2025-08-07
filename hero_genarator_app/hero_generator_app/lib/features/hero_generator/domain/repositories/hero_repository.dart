import '../entities/hero_entity.dart';

abstract class HeroRepository {
  Future<List<HeroEntity>> getAllHeroes();
  Future<void> createHero(HeroEntity hero);
  Future<void> updateHero(HeroEntity hero);
  Future<void> deleteHero(String id);
}
