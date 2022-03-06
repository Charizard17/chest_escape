import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:provider/provider.dart';

import '../game/game.dart';
import '../models/settings.dart';

class AudioManager extends Component with HasGameRef<ChestEscape> {
  @override
  Future<void>? onLoad() async {
    FlameAudio.bgm.initialize();

    await FlameAudio.audioCache.loadAll([
      'SynthBomb.mp3',
      'hit_sound.mp3',
    ]);

    return super.onLoad();
  }

    void playBackgroundMusic(String filename) {
    if (gameRef.buildContext != null) {
      if (Provider.of<Settings>(gameRef.buildContext!, listen: false)
          .backgroundMusic) {
        FlameAudio.bgm.play(filename, volume: 0.5);
      }
    }
  }

  void playSoundEffects(String filename) {
    if (gameRef.buildContext != null) {
      if (Provider.of<Settings>(gameRef.buildContext!, listen: false)
          .soundEffects) {
        FlameAudio.play(filename);
      }
    }
  }

  void stopBackgroundMusic() {
    FlameAudio.bgm.stop();
  }

}
