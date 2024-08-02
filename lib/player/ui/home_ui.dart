import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geko_player/player/helpers/path.dart';
import 'package:geko_player/player/helpers/file.dart';
import 'package:geko_player/player/ui/player_ui.dart';
import 'package:path/path.dart' as path;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<FileSystemEntity> _videoFiles = [];
  Map<String, String> _thumbnails = {};
  Directory? _selectedDirectory;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _selectedDirectory = Directory(getVideoPath());
    await _loadVideos();
  }

  Future<void> _loadVideos() async {
    final futures = <Future<MapEntry<String, String>>>[];
    if (_selectedDirectory == null) return;
    final videoFiles = await getFiles(_selectedDirectory!);
    for (var file in videoFiles) {
      futures.add(getThumbnailPath(file.path).then((thumbnail) {
        return MapEntry(file.path, thumbnail ?? '');
      }));
    }
    final results = await Future.wait(futures);
    _thumbnails = Map<String, String>.fromEntries(results);
    setState(() => _videoFiles = videoFiles);
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
        builder: (context) => PlayerUI(videoPath: videoPath),
      ),
    );
  }
}
