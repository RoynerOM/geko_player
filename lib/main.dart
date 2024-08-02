import 'package:flutter/material.dart';
import 'package:geko_player/app.dart';
import 'package:media_kit/media_kit.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(App(videoPath: args.isNotEmpty ? args[0] : null));
}
