import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:process_run/process_run.dart';

String getVideoPath() {
  try {
    final result =
        runExecutableArgumentsSync('cmd', ['/c', 'echo', '%USERPROFILE%']);
    if (result.exitCode == 0) {
      return result.stdout.trim() + '\\Videos';
    } else {
      return 'Error retrieving variable: ${result.stderr}';
    }
  } catch (e) {
    return 'Exception: $e';
  }
}

Future<String?> getThumbnailPath(String videoPath) async {
  try {
    final directory = await getTemporaryDirectory();
    final ffmpegPath = '${directory.path}/ffmpeg.exe';
    final byteData = await rootBundle.load('tools/ffmpeg.exe');
    final buffer = byteData.buffer.asUint8List();
    final file = File(ffmpegPath);
    await file.writeAsBytes(buffer);
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
