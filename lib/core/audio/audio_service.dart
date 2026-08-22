abstract interface class AudioService {
  Future<void> playCorrect();
  Future<void> playIncorrect();
  Future<void> playLevelComplete();
  Future<void> dispose();
}
