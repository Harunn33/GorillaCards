import 'package:assets_audio_player/assets_audio_player.dart';

enum Sounds {
  wrong("wrongSound"),
  correct("correctSound");

  final String value;
  const Sounds(
    this.value,
  );

  AssetsAudioPlayer get assetsAudioPlayer => AssetsAudioPlayer();
}

extension PlaySounds on Sounds {
  static correct() {
    Sounds.correct.assetsAudioPlayer
        .open(Audio("assets/sounds/${Sounds.correct.value}.mp3"));
  }

  static wrong() {
    Sounds.wrong.assetsAudioPlayer
        .open(Audio("assets/sounds/${Sounds.wrong.value}.mp3"));
  }
}
