import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'emoji_state.dart';

class EmojiCubit extends Cubit<EmojiState> {
  EmojiCubit() : super(EmojiInitial());

  List<String> emojis = [
    '😀', // Grinning Face
    '😂', // Face with Tears of Joy
    '😍', // Smiling Face with Heart-Eyes
    '😎', // Smiling Face with Sunglasses
    '😊', // Smiling Face with Smiling Eyes
    '🥰', // Smiling Face with Hearts
    '🤔', // Thinking Face
    '🙌', // Raising Hands
    '🙏', // Folded Hands
    '👍', // Thumbs Up
    '👎', // Thumbs Down
    '🔥', // Fire
    '💯', // Hundred Points
    '🎉', // Party Popper
    '🥳', // Partying Face
    '💡', // Light Bulb
    '🚀', // Rocket
    '🌍', // Earth Globe Europe-Africa
    '🧠', // Brain
    '💻', // Laptop
    '📱', // Mobile Phone
  ];

  void getEmoji() {
    emojis.shuffle();
    emit(EmojitLoaded(emoji: emojis.first));
  }
}
