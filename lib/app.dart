import 'package:flutter/material.dart';
import 'package:geko_player/player/ui/home_ui.dart';
import 'package:geko_player/player/ui/player_ui.dart';

class App extends StatelessWidget {
  final String? videoPath;
  const App({super.key, this.videoPath});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geko Player',
      debugShowCheckedModeBanner: false,
      home: videoPath != null
          ? PlayerUI(videoPath: videoPath!, onlyPlayer: true)
          : const HomeView(),
    );
  }
}
