import 'package:flutter_bloc/flutter_bloc.dart';
import 'image_event.dart';
import 'image_state.dart';
import '../../../domain/usecases/generate_image.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final GenerateImage generateImage;

  ImageBloc(this.generateImage) : super(ImageInitial()) {
    on<GenerateImageEvent>((event, emit) async {
      emit(ImageLoading());
      try {
        final result = await generateImage(event.prompt);
        emit(ImageGenerated(result.url));
      } catch (e) {
        emit(ImageError(e.toString()));
      }
    });
  }
}
