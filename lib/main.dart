import 'package:flutter/material.dart';
import 'package:geko_player/video_directory.dart';
import 'package:geko_player/video_player.dart';
import 'package:media_kit/media_kit.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(AppWidget(videoPath: args.isNotEmpty ? args[0] : null));
}

class AppWidget extends StatelessWidget {
  final String? videoPath;
  const AppWidget({super.key, this.videoPath});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geko Player',
      debugShowCheckedModeBanner: false,
      home: videoPath != null
          ? VideoPlayerUI(videoPath: videoPath!)
          : const VideoDirectoryScreen(),
    );
  }
}
