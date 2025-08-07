import '../repositories/hero_repository.dart';

class DeleteHero {
  final HeroRepository repository;
  DeleteHero(this.repository);

  Future<void> call(String id) => repository.deleteHero(id);
}
