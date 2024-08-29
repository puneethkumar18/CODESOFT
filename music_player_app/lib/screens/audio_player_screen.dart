import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioPlayerScreen extends StatefulWidget {
  static const String routeName = '/audio-playerScreen';
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final onAudioQuery = OnAudioQuery();

  List<AudioSource> audioSource = [];
  List<SongModel> audioModel = [];
  bool isPlaying = false;
  double volume = 0.5;
  int songIndex = 0;
  int loopMode = 0;
  Duration currentMusicDuration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }

  @override
  void initState() {
    super.initState();
    positionState();

    isPlayingState();
    curentAudioDuration();
    makeAudioSource();
  }

  void makeAudioSource() async {
    audioModel = await onAudioQuery.querySongs(
      sortType: SongSortType.DISPLAY_NAME,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    audioModel.map((song) {
      audioSource.add(AudioSource.file(song.data));
    }).toList();
    makePlayList();
    setState(() {});
  }

  void makePlayList() async {
    currentMusicDuration = (await _audioPlayer.setAudioSource(
      initialIndex: songIndex,
      ConcatenatingAudioSource(
        children: audioSource,
      ),
    ))!;
    setState(() {});
  }

  void curentAudioDuration() {
    _audioPlayer.durationStream.listen((val) {
      setState(() {
        currentMusicDuration = val!;
      });
    });
  }

  void positionState() {
    _audioPlayer.positionStream.listen((onData) {
      setState(() {
        position = onData;
      });
    });
  }

  void isPlayingState() {
    _audioPlayer.playingStream.listen((val) {
      isPlaying = val;
    });
    setState(() {});
  }

  playNext() async {
    await _audioPlayer.seekToNext();
    if (loopMode == 0 && songIndex != audioModel.length - 1) songIndex++;
    if (loopMode == 2) songIndex = songIndex % audioModel.length;
  }

  playPrev() async {
    await _audioPlayer.seekToPrevious();
    if (loopMode == 0 && songIndex != 0) songIndex--;
    if (loopMode == 2) songIndex = songIndex % audioModel.length;
  }

  void seek() async {
    await _audioPlayer.seek(position);
  }

  void play() async {
    await _audioPlayer.play();
    setState(() {});
  }

  void pause() async {
    await _audioPlayer.pause();
    setState(() {});
  }

  void setVolume() async {
    await _audioPlayer.setVolume(volume);
    setState(() {});
  }

  void shuffle() {
    _audioPlayer.shuffle();
    setState(() {});
  }

  void loop() async {
    if (loopMode == 1) {
      await _audioPlayer.setLoopMode(LoopMode.one);
    } else if (loopMode == 2) {
      await _audioPlayer.setLoopMode(LoopMode.all);
    } else {
      await _audioPlayer.setLoopMode(LoopMode.off);
    }
  }

  String formName(String url) {
    return url.split('/')[2].split('.')[0];
  }

  String formString(int seconds) {
    return '${Duration(seconds: seconds)}'.split('.')[0].padLeft(8, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          centerTitle: true,
          title: const Text(
            "Audio Player",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return DraggableScrollableSheet(
                              expand: false,
                              builder: (context, scrollcontroller) {
                                return SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Song List",
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Divider(
                                          thickness: 2,
                                          color: Colors.black,
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: audioModel.length,
                                          controller: scrollcontroller,
                                          itemBuilder: (context, index) {
                                            final song = audioModel[index];
                                            return InkWell(
                                              onTap: () {
                                                songIndex = index;
                                                makePlayList();
                                                Future.delayed(
                                                  const Duration(seconds: 2),
                                                );
                                                Navigator.pop(context);
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  song.title,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                trailing: songIndex == index
                                                    ? const Icon(
                                                        Icons.music_note,
                                                        size: 28,
                                                      )
                                                    : null,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
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
                        shuffle();
                      },
                      icon: const Icon(
                        Icons.shuffle,
                        size: 35,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (loopMode < 2) {
                          loopMode += 1;
                        } else {
                          loopMode = 0;
                        }
                        loop();
                        setState(() {});
                      },
                      icon: loopMode == 0
                          ? const Icon(
                              Icons.repeat_rounded,
                              size: 35,
                              color: Colors.black,
                            )
                          : loopMode == 1
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
                      value: position.inSeconds.toDouble(),
                      min: 0,
                      max: currentMusicDuration.inSeconds.toDouble(),
                      onChanged: (double val) {
                        final duration = Duration(seconds: val.toInt());
                        position = duration;
                        seek();
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
                            formString(
                              position.inSeconds,
                            ),
                          ),
                          Text(
                            formString(
                              currentMusicDuration.inSeconds,
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
                            playPrev();
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
                            isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                            size: 100,
                            color: Colors.black87,
                          ),
                          onPressed: () {
                            if (isPlaying) {
                              pause();
                            } else {
                              play();
                            }
                            setState(() {});
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            playNext();
                            setState(() {});
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
                            value: volume,
                            min: 0,
                            max: 1,
                            onChanged: (val) {
                              volume = val;
                              setVolume();
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
      ),
    );
  }
}
