import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geko_player/path_videos.dart';
import 'package:geko_player/video_player.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:process_run/shell_run.dart';

class VideoDirectoryScreen extends StatefulWidget {
  const VideoDirectoryScreen({super.key});

  @override
  State<VideoDirectoryScreen> createState() => _VideoDirectoryScreenState();
}

class _VideoDirectoryScreenState extends State<VideoDirectoryScreen> {
  List<FileSystemEntity> _videoFiles = [];
  Map<String, String> _thumbnails = {};
  Directory? _selectedDirectory;

  @override
  void initState() {
    super.initState();
    _pickDirectory();
  }

  Future<void> _pickDirectory() async {
    final videoPath = getPathVideos();
    _selectedDirectory = Directory(videoPath);
    await _loadVideos();
  }

  Future<void> _loadVideos() async {
    final futures = <Future<MapEntry<String, String>>>[];
    if (_selectedDirectory == null) return;
    final videoFiles = await _getVideoFiles(_selectedDirectory!);
    for (var file in videoFiles) {
      futures.add(_getThumbnailPath(file.path).then((thumbnail) {
        return MapEntry(file.path, thumbnail ?? '');
      }));
    }
    final results = await Future.wait(futures);
    _thumbnails = Map<String, String>.fromEntries(results);
    setState(() => _videoFiles = videoFiles);
  }

  Future<List<FileSystemEntity>> _getVideoFiles(Directory dir) async {
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

  Future<String?> _getThumbnailPath(String videoPath) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos en ${_selectedDirectory?.path ?? ""}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder_open),
            onPressed: () async {
              String? directoryPath =
                  await FilePicker.platform.getDirectoryPath();
              if (directoryPath != null) {
                _selectedDirectory = Directory(directoryPath);
                setState(() {
                  _videoFiles.clear();
                });
                await _loadVideos();
              }
            },
          ),
        ],
      ),
      body: _videoFiles.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: 7,
                mainAxisSpacing: 7,
                childAspectRatio: 16 / 9,
                maxCrossAxisExtent: 300,
              ),
              itemCount: _videoFiles.length,
              itemBuilder: (context, index) {
                final file = _videoFiles[index];
                final thumbnail = _thumbnails[file.path];
                return GestureDetector(
                  onTap: () => _playVideo(file.path),
                  child: GridTile(
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(
                        path.basename(file.path),
                        style: const TextStyle(fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    child: getThumbnail(thumbnail ?? ''),
                  ),
                );
              },
            ),
    );
  }

  Widget getThumbnail(String thumbnail) {
    try {
      if (thumbnail.isEmpty) {
        return const Icon(Icons.video_camera_back_outlined);
      }

      return Image.file(File(thumbnail), fit: BoxFit.cover);
    } catch (e) {
      return const CircularProgressIndicator();
    }
  }

  void _playVideo(String videoPath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerUI(videoPath: videoPath),
      ),
    );
  }
}
