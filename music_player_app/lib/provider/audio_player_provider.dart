import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<String> audiolist = [
    "assets/audio/adangatha_asuran.mp3",
    "assets/audio/water_packet.mp3",
  ];

  int songIndex = 0;
  bool isPlaying = false;
  double volume = 1;
  int loopMode = 0;
  Duration currentMusicDuration = Duration.zero;
  Duration position = Duration.zero;

  AudioPlayerProvider() {
    setSong();
  }

  bool addSong(String url) {
    bool isPresent = false;
    for (int i = 0; i < audiolist.length; i++) {
      if (url == audiolist[i]) {
        isPresent = true;
      }
    }
    if (isPresent == false) {
      audiolist.add(url);
      notifyListeners();
    }
    return isPresent;
  }

  void playNext() {
    if (audiolist.length - 1 > songIndex) {
      songIndex += 1;
      setSong();
      play();
    }
    notifyListeners();
  }

  void stop() async {
    await _audioPlayer.stop();
    isPlaying = false;
  }

  void shuffleSongs() {
    audiolist.shuffle();
  }

  String formName(String url) {
    return url.split('/')[2].split('.')[0];
  }

  void playPrev() {
    if (songIndex > 0) {
      songIndex -= 1;
      setSong();
      play();
    }
    notifyListeners();
  }

  void setVolume() async {
    await _audioPlayer.setVolume(volume);
    notifyListeners();
  }

  void loop() async {
    if (loopMode == 1) {
      await _audioPlayer.setLoopMode(LoopMode.one);
    } else if (loopMode == 2) {
      await _audioPlayer.setLoopMode(LoopMode.all);
    } else {
      await _audioPlayer.setLoopMode(LoopMode.off);
    }
    notifyListeners();
  }

  void setSong() async {
    final duration = await _audioPlayer.setAsset(
      audiolist[songIndex],
    );
    currentMusicDuration = duration!;
    notifyListeners();
  }

  void play() async {
    isPlaying = true;
    await _audioPlayer.play();
    notifyListeners();
  }

  void pause() async {
    isPlaying = false;
    await _audioPlayer.pause();
    notifyListeners();
  }

  void seek(Duration curr) async {
    await _audioPlayer.seek(curr);
    notifyListeners();
  }

  String formString(int seconds) {
    return '${Duration(seconds: seconds)}'.split('.')[0].padLeft(8, '0');
  }
}
