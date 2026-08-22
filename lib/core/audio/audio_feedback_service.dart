import 'package:audioplayers/audioplayers.dart';

import 'audio_service.dart';

class AudioFeedbackService implements AudioService {
  final AudioPlayer _player = AudioPlayer();

  @override
  Future<void> playCorrect() => _play('sounds/common/correct.wav', .72);

  @override
  Future<void> playIncorrect() => _play('sounds/common/incorrect.wav', .55);

  Future<void> _play(String asset, double volume) async {
    try {
      await _player.stop();
      await _player.play(AssetSource(asset), volume: volume);
    } catch (_) {
      // Audio feedback must never interrupt an exercise.
    }
  }

  @override
  Future<void> dispose() => _player.dispose();
}
