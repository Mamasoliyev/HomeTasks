import 'package:dartz/dartz.dart';
import 'package:get_id_ddarsi/core/expretions/failtures.dart';
import 'package:get_id_ddarsi/futures/random_cat/data/source/cat_image_data_source.dart';
import 'package:get_id_ddarsi/futures/random_cat/domain/entities/cat_image_entity';
import 'package:get_id_ddarsi/futures/random_cat/domain/repos/cat_image_repos.dart';

class CatImageRepositoryImpl implements CatImageRepository {
  final CatImageRemoteDataSource remoteDataSource;

  CatImageRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, CatImage>> getRandomCatImage() async {
    try {
      final image = await remoteDataSource.getRandomCatImage();
      return Right(image);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
