import '../../domain/entities/image_entity.dart';
import '../../domain/repositories/image_repository.dart';
import '../datasources/image_remote_datasource.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageRemoteDataSource remoteDataSource;

  ImageRepositoryImpl(this.remoteDataSource);

  @override
  Future<ImageEntity> generateImage(String prompt) async {
    return await remoteDataSource.generateImage(prompt);
  }
  Future<String> getImageUrl(String prompt) async {
    final imageEntity = await generateImage(prompt);
    return imageEntity.url;
  }
}
