import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class AudioPreviewProvider extends ChangeNotifier {
  final AudioPlayer player = AudioPlayer();

  bool loading = false;
  bool playing = false;
  bool idle = true;

  String? currentPath;

  int durationMs = 0;
  int positionMs = 0;

  AudioPreviewProvider() {
    _init();
  }

  void _init() {
    player.onPlayerStateChanged.listen((state) {
      switch (state) {
        case PlayerState.playing:
          playing = true;
          loading = false;
          idle = false;
          break;

        case PlayerState.paused:
          playing = false;
          loading = false;
          break;

        case PlayerState.completed:
          playing = false;
          loading = false;
          idle = true;
          positionMs = 0;
          break;

        case PlayerState.stopped:
          playing = false;
          loading = false;
          idle = true;
          break;

        case PlayerState.disposed:
          playing = false;
          loading = false;
          idle = true;
          break;
      }
      notifyListeners();
    });

    player.onDurationChanged.listen((d) {
      durationMs = d.inMilliseconds;
      notifyListeners();
    });

    player.onPositionChanged.listen((p) {
      positionMs = p.inMilliseconds;
      notifyListeners();
    });
  }

  Future<void> togglePlay(
    String? path, [
    bool? loadingAudio,
    bool? palyingAudio,
  ]) async {
    if (path == null) return;
    if (loading) return;

    if (currentPath == path) {
      if (playing) {
        await player.pause();
        palyingAudio = false;
      } else {
        await player.resume();
        palyingAudio = false;
      }
    } else {
      await player.stop();

      currentPath = path;
      durationMs = 0;
      positionMs = 0;
      loading = true;
      loadingAudio = true;
      idle = false;

      notifyListeners();

      final Source source = kIsWeb ? UrlSource(path) : DeviceFileSource(path);

      await player.play(source);
      palyingAudio = true;
      final d = await player.getDuration();
      if (d != null && durationMs == 0) {
        durationMs = d.inMilliseconds;
        notifyListeners();
      }
    }
  }

  Future<void> seekTo(double fraction) async {
    if (durationMs == 0) return;

    final target = Duration(
      milliseconds: (durationMs * fraction.clamp(0.0, 1.0)).round(),
    );

    await player.seek(target);
  }

  double get progress {
    if (durationMs == 0) return 0;
    return (positionMs / durationMs).clamp(0.0, 1.0);
  }

  double progressFor(String? path) => path == currentPath ? progress : 0.0;

  bool isLoadingFor(String? path) => path == currentPath && loading;

  bool isPlayingFor(String? path) => path == currentPath && playing;

  String get posLabel => _format(Duration(milliseconds: positionMs));
  String get durLabel => _format(Duration(milliseconds: durationMs));

  String _format(Duration d) {
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  clearPath() {
    currentPath = null;
    notifyListeners();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
