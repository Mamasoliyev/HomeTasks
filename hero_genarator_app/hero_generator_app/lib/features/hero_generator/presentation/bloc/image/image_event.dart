abstract class ImageEvent {}

class GenerateImageEvent extends ImageEvent {
  final String prompt;
  GenerateImageEvent(this.prompt);
}
