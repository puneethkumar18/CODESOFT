import 'package:flutter/material.dart';
import 'package:music_player_app/common/utils.dart';
import 'package:music_player_app/provider/audio_player_provider.dart';
import 'package:music_player_app/screens/playlist_screen.dart';
import 'package:provider/provider.dart';

class AudioAddScreen extends StatefulWidget {
  static const String routeName = '/addAudoScreen';
  const AudioAddScreen({super.key});

  @override
  State<AudioAddScreen> createState() => _AudioAddScreenState();
}

class _AudioAddScreenState extends State<AudioAddScreen> {
  final TextEditingController _songUrlController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _songUrlController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioPlayerProvider =
        Provider.of<AudioPlayerProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Audio",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _songUrlController,
              decoration: InputDecoration(
                hintText: "Enter the song Url here...",
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                if (audioPlayerProvider
                    .addSong('assets/audio/${_songUrlController.text}.mp3')) {
                  showSnackBar(
                    context: context,
                    message: "Song is already in PlayList",
                  );
                }
                Navigator.pushNamed(context, PlaylistScreen.routeName);
              },
              child: const Text("Add Audio"),
            ),
          ],
        ),
      ),
    );
  }
}
