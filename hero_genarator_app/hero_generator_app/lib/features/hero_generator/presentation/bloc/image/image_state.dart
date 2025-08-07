abstract class ImageState {}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageGenerated extends ImageState {
  final String imageUrl;
  ImageGenerated(this.imageUrl);
}

class ImageError extends ImageState {
  final String message;
  ImageError(this.message);
}
