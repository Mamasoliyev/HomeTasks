import '../../domain/entities/hero_entity.dart';
import '../../domain/repositories/hero_repository.dart';
import '../datasources/hero_remote_datasource.dart';
import '../models/hero_model.dart';

class HeroRepositoryImpl implements HeroRepository {
  final HeroRemoteDataSource remoteDataSource;

  HeroRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<HeroEntity>> getAllHeroes() async {
    return await remoteDataSource.getAllHeroes();
  }

  @override
  Future<void> createHero(HeroEntity hero) async {
    final model = HeroModel(
      id: hero.id,
      name: hero.name,
      universe: hero.universe,
      image: hero.image,
    );
    await remoteDataSource.createHero(model);
  }

  @override
  Future<void> updateHero(HeroEntity hero) async {
    final model = HeroModel(
      id: hero.id,
      name: hero.name,
      universe: hero.universe,
      image: hero.image,
    );
    await remoteDataSource.updateHero(model);
  }

  @override
  Future<void> deleteHero(String id) async {
    await remoteDataSource.deleteHero(id);
  }
}
