import 'package:flutter/material.dart';

import 'package:music_player_app/provider/audio_player_provider.dart';
import 'package:music_player_app/screens/audio_player_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class PlaylistScreen extends StatefulWidget {
  static const String routeName = '/play-list';
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final OnAudioQuery onAudioQuery = OnAudioQuery();

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  void _checkPermission() {
    Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    final audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Play List",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: onAudioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, items) {
          if (items.data == null) {
            return ListView.builder(
              itemCount: audioPlayerProvider.audiolist.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    audioPlayerProvider.songIndex = index;
                    audioPlayerProvider.setSong();
                    if (!audioPlayerProvider.isPlaying) {
                      audioPlayerProvider.play();
                    }
                    Navigator.pushNamed(context, AudioPlayerScreen.routeName);
                  },
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(
                        Icons.logo_dev,
                      ),
                    ),
                    title: Text(
                      audioPlayerProvider.formName(
                        audioPlayerProvider.audiolist[index],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return ListView.builder(
            itemCount: items.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(
                    Icons.logo_dev,
                  ),
                ),
                title: Text(
                  audioPlayerProvider.audiolist[index],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AudioPlayerScreen.routeName,
          );
        },
        child: const Icon(
          Icons.play_arrow_rounded,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
