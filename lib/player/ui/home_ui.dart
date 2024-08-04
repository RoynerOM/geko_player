import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geko_player/player/config/path.dart';
import 'package:geko_player/player/config/video_loader.dart';
import 'package:geko_player/player/ui/player_ui.dart';
import 'package:path/path.dart' as path;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<void> _initFuture;
  late VideoLoader _videoLoader;
  Map<String, String> _thumbnails = {};
  Directory? _selectedDirectory;

  @override
  void initState() {
    super.initState();
    _initFuture = _init();
  }

  Future<void> _init() async {
    final videoPath = await getVideoPath();
    _selectedDirectory = Directory(videoPath);
    _videoLoader = VideoLoader(_selectedDirectory!);
    await _loadVideos();
  }

  Future<void> _loadVideos() async {
    if (_selectedDirectory == null) return;
    final videoFiles = await _videoLoader.getFiles();
    final futures = <Future<MapEntry<String, String>>>[];

    for (var file in videoFiles) {
      futures.add(generateThumbnail(file.path).then((thumbnail) {
        return MapEntry(file.path, thumbnail ?? '');
      }));
    }
    final results = await Future.wait(futures);
    setState(() {
      _thumbnails = Map<String, String>.fromEntries(results);
    });
  }

  Future<void> _pickDirectory() async {
    String? directoryPath = await FilePicker.platform.getDirectoryPath();
    if (directoryPath != null) {
      setState(() {
        _selectedDirectory = Directory(directoryPath);
        _videoLoader = VideoLoader(_selectedDirectory!);
        _thumbnails.clear();
      });
      await _loadVideos();
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
            onPressed: _pickDirectory,
          ),
        ],
      ),
      body: FutureBuilder(
        future: _initFuture,
        builder: (context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.hasError) {
            return Center(child: Text('Error: ${state.error}'));
          }

          if (_selectedDirectory == null) {
            return const Center(child: Text('No directory selected'));
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              crossAxisSpacing: 7,
              mainAxisSpacing: 7,
              childAspectRatio: 16 / 9,
              maxCrossAxisExtent: 300,
            ),
            itemCount: _thumbnails.keys.length,
            itemBuilder: (_, index) {
              final filePath = _thumbnails.keys.elementAt(index);
              final thumbnail = _thumbnails[filePath];
              return GestureDetector(
                onTap: () => _playVideo(filePath),
                child: GridTile(
                  footer: GridTileBar(
                    backgroundColor: Colors.black54,
                    title: Text(
                      path.basename(filePath),
                      style: const TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  child: getThumbnail(thumbnail ?? ''),
                ),
              );
            },
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
