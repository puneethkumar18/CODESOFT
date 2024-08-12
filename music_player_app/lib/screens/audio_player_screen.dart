import 'package:flutter/material.dart';
import 'package:music_player_app/provider/audio_player_provider.dart';
import 'package:music_player_app/screens/audio_add_screen.dart';
import 'package:music_player_app/screens/playlist_screen.dart';
import 'package:provider/provider.dart';

class AudioPlayerScreen extends StatefulWidget {
  static const String routeName = '/audio-playerScreen';
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final audioPlayer =
        Provider.of<AudioPlayerProvider>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AudioAddScreen.routeName,
                );
              },
              icon: const Icon(
                Icons.playlist_add_outlined,
                color: Colors.black,
                size: 30,
              ),
            ),
          ],
          title: const Text(
            "Audio Player",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Column(
            children: [
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.music_note_outlined,
                  color: Colors.white30,
                  size: 200,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        PlaylistScreen.routeName,
                      );
                    },
                    icon: const Icon(
                      Icons.menu,
                      size: 35,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      audioPlayer.shuffleSongs();
                    },
                    icon: const Icon(
                      Icons.shuffle,
                      size: 35,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (audioPlayer.loopMode < 2) {
                        audioPlayer.loopMode += 1;
                      } else {
                        audioPlayer.loopMode = 0;
                      }
                      audioPlayer.loop();
                      setState(() {});
                    },
                    icon: audioPlayer.loopMode == 0
                        ? const Icon(
                            Icons.repeat_rounded,
                            size: 35,
                            color: Colors.black,
                          )
                        : audioPlayer.loopMode == 1
                            ? const Icon(
                                Icons.repeat_one_rounded,
                                size: 35,
                                color: Colors.black,
                              )
                            : const Icon(
                                Icons.repeat_on_rounded,
                                size: 35,
                                color: Colors.black,
                              ),
                  ),
                  IconButton(
                    onPressed: () {
                      audioPlayer.stop();
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.stop_outlined,
                      size: 35,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Slider(
                    value: audioPlayer.position.inSeconds.toDouble(),
                    min: 0,
                    max: audioPlayer.currentMusicDuration.inSeconds.toDouble() +
                        1,
                    onChanged: (double val) {
                      final duration = Duration(seconds: val.toInt());
                      audioPlayer.position = duration;
                      audioPlayer.seek(duration);
                      setState(() {});
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          audioPlayer.formString(
                            audioPlayer.position.inSeconds,
                          ),
                        ),
                        Text(
                          audioPlayer.formString(
                            audioPlayer.currentMusicDuration.inSeconds,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          audioPlayer.playPrev();
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.fast_rewind_rounded,
                          size: 60,
                          color: Colors.black87,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          audioPlayer.isPlaying == true
                              ? Icons.pause
                              : Icons.play_arrow_rounded,
                          size: 100,
                          color: Colors.black87,
                        ),
                        onPressed: () {
                          if (audioPlayer.isPlaying) {
                            audioPlayer.pause();
                          } else {
                            audioPlayer.play();
                          }

                          setState(() {});
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          audioPlayer.playNext();
                        },
                        icon: const Icon(
                          Icons.fast_forward_rounded,
                          size: 60,
                          color: Colors.black87,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.volume_off_rounded,
                        size: 25,
                        color: Colors.black87,
                      ),
                      Expanded(
                        child: Slider(
                          value: audioPlayer.volume,
                          min: 0,
                          max: 6,
                          onChanged: (val) {
                            audioPlayer.volume = val;
                            audioPlayer.setVolume();
                            setState(() {});
                          },
                        ),
                      ),
                      const Icon(
                        Icons.volume_up_rounded,
                        size: 25,
                        color: Colors.black87,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
