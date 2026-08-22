import 'package:audioplayers/audioplayers.dart';

import 'audio_service.dart';

class AudioFeedbackService implements AudioService {
  final AudioPlayer _player = AudioPlayer();
  int _playbackId = 0;

  @override
  Future<void> playCorrect() => _play('sounds/common/correct.mp3', .72);

  @override
  Future<void> playIncorrect() => _play('sounds/common/incorrect.wav', .55);

  Future<void> _play(String asset, double volume) async {
    final playbackId = ++_playbackId;
    try {
      await _player.stop();
      await _player.play(AssetSource(asset), volume: volume);
      await Future<void>.delayed(const Duration(milliseconds: 1550));
      if (playbackId != _playbackId) return;
      for (var step = 3; step >= 1; step--) {
        await _player.setVolume(volume * step / 4);
        await Future<void>.delayed(const Duration(milliseconds: 60));
        if (playbackId != _playbackId) return;
      }
      await _player.stop();
    } catch (_) {
      // Audio feedback must never interrupt an exercise.
    }
  }

  @override
  Future<void> dispose() => _player.dispose();
}
