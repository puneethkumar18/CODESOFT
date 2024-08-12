import 'package:flutter/material.dart';
import 'package:music_player_app/screens/audio_add_screen.dart';
import 'package:music_player_app/screens/audio_player_screen.dart';
import 'package:music_player_app/screens/playlist_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AudioPlayerScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AudioPlayerScreen(),
      );
    case PlaylistScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const PlaylistScreen(),
      );
    case AudioAddScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AudioAddScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const Center(
          child: Text("Route Does not Exists"),
        ),
      );
  }
}
