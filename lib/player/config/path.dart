import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:process_run/process_run.dart';

Future<String> getVideoPath() async {
  try {
    final result =
        await runExecutableArguments('cmd', ['/c', 'echo', '%USERPROFILE%']);
    if (result.exitCode == 0) {
      return result.stdout.trim() + '\\Videos';
    } else {
      return 'Error retrieving variable: ${result.stderr}';
    }
  } catch (e) {
    return 'Exception: $e';
  }
}

Future<String?> generateThumbnail(String videoPath) async {
  try {
    final directory = await getTemporaryDirectory();
    final ffmpegPath = await _ensureFFmpegExists(directory);

    final thumbnailPath =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';

    final shell = Shell();
    await shell.run('''
      $ffmpegPath -i "$videoPath" -ss 00:00:01.000 -vframes 1 "$thumbnailPath"
    ''');

    final thumbnailFile = File(thumbnailPath);

    if (await thumbnailFile.exists()) {
      return thumbnailFile.path;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<String> _ensureFFmpegExists(Directory directory) async {
  final ffmpegPath = '${directory.path}/ffmpeg.exe';
  final file = File(ffmpegPath);
  if (!await file.exists()) {
    final byteData = await rootBundle.load('tools/ffmpeg.exe');
    await file.writeAsBytes(byteData.buffer.asUint8List());
  }
  return ffmpegPath;
}
