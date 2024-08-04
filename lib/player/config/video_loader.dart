import 'dart:io';

import 'package:path/path.dart' as path;

class VideoLoader {
  List<FileSystemEntity>? _cachedFiles;
  final Directory _directory;

  VideoLoader(this._directory);

  Future<List<FileSystemEntity>> getFiles() async {
    if (_cachedFiles != null) {
      return _cachedFiles!;
    }
    _cachedFiles = await _loadFiles();
    return _cachedFiles!;
  }

  Future<List<FileSystemEntity>> _loadFiles() async {
    final List<FileSystemEntity> videoFiles = [];
    final stream = _directory.list(recursive: true);
    await for (var entity in stream) {
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
}
