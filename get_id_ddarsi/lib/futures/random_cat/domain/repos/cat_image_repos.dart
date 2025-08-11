import 'package:dartz/dartz.dart';
import 'package:get_id_ddarsi/core/expretions/failtures.dart';
import 'package:get_id_ddarsi/futures/random_cat/domain/entities/cat_image_entity';

abstract class CatImageRepository {
  Future<Either<Failure, CatImage>> getRandomCatImage();
}
