import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';

import '../helpers/settings.dart';

class AudioManager {
  late Settings settings;
  AudioManager._internal();

  static final AudioManager _instance = AudioManager._internal();

  static AudioManager get instance => _instance;

  Future<void> init(List<String> files, Settings settings) async {
    this.settings = settings;
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll(files);
  }

  // start, pause, resume and stop background music
  void startBackgroundMusic(String fileName) {
    if (settings.backgroundMusic) {
      FlameAudio.bgm.play(fileName, volume: 0.5);
    }
  }

  void pauseBackgroundMusic() {
    if (settings.backgroundMusic) {
      FlameAudio.bgm.pause();
    }
  }

  void resumeBackgroundMusic() {
    if (settings.backgroundMusic) {
      FlameAudio.bgm.resume();
    }
  }

  void stopBackgroundMusic() {
    FlameAudio.bgm.stop();
  }

  // play the given audio file once
  void playSoundEffects(String fileName) {
    if (settings.soundEffects) {
      FlameAudio.audioCache.play(fileName);
    }
  }
}
