part of 'emoji_cubit.dart';

@immutable
sealed class EmojiState {
  final String? emoji;

  const EmojiState({this.emoji});
}

final class EmojiInitial extends EmojiState {
  const EmojiInitial() : super(emoji: "😴");
}

final class EmojitLoaded extends EmojiState {
  const EmojitLoaded({required String emoji}) : super(emoji: emoji);
}

final class EmojiError extends EmojiState {
  final String message;

  const EmojiError({required this.message});
}
