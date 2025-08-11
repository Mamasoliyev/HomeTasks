import 'package:dartz/dartz.dart';
import 'package:get_id_ddarsi/core/expretions/failtures.dart';
import 'package:get_id_ddarsi/futures/random_cat/domain/entities/cat_image_entity';
import 'package:get_id_ddarsi/futures/random_cat/domain/repos/cat_image_repos.dart';

class GetRandomCatImage {
  final CatImageRepository repository;

  GetRandomCatImage(this.repository);

  Future<Either<Failure, CatImage>> call() async {
    return await repository.getRandomCatImage();
  }
}
