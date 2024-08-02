import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoPlayerUI extends StatefulWidget {
  final String videoPath;

  const VideoPlayerUI({super.key, required this.videoPath});

  @override
  State<VideoPlayerUI> createState() => _VideoPlayerUIState();
}

class _VideoPlayerUIState extends State<VideoPlayerUI> {
  late Player _player;
  late final controller = VideoController(_player);
  bool showAppbar = true;
  int seconds = 4;
  Timer? _hideTimer;
  FocusNode focus = FocusNode();
  @override
  void initState() {
    _player = Player();
    _player.open(Media(widget.videoPath));
    super.initState();
  }

  void _resetHideTimer() {
    _hideTimer?.cancel();
    setState(() {
      showAppbar = true;
    });
    _hideTimer = Timer(Duration(seconds: seconds), () {
      if (mounted) {
        setState(() {
          showAppbar = false;
        });
      }
    });
  }

  void _togglePlayPause() {
    focus.requestFocus();
    if (_player.state.playing) {
      _player.pause();
    } else {
      _player.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => _resetHideTimer(),
      onHover: (event) => _resetHideTimer(),
      onExit: (event) => setState(() => showAppbar = false),
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              InkWell(
                onTap: _togglePlayPause,
                child: Focus(
                  focusNode: focus,
                  onKeyEvent: (_, KeyEvent key) {
                    if (key is KeyDownEvent &&
                        key.logicalKey == LogicalKeyboardKey.space) {
                      _togglePlayPause();
                      return KeyEventResult.handled;
                    }
                    return KeyEventResult.ignored;
                  },
                  child: Video(
                    controller: controller,
                  ),
                ),
              ),
              if (showAppbar)
                BackButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
