import 'package:process_run/stdio.dart';
import 'package:path/path.dart' as path;

Future<List<FileSystemEntity>> getFiles(Directory dir) async {
  final List<FileSystemEntity> videoFiles = [];
  final entities = await dir.list(recursive: true).toList();
  for (var entity in entities) {
    if (entity is File && _isVideoFile(entity)) {
      videoFiles.add(entity);
    }
  }
  return videoFiles;
}

bool _isVideoFile(File file) {
  final extensions = ['mp4', 'avi', 'mkv', 'mov'];
  final ext = path.extension(file.path).replaceFirst('.', '');
  return extensions.contains(ext.toLowerCase());
}
