import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class PlayerUI extends StatefulWidget {
  final String videoPath;
  final bool onlyPlayer;
  const PlayerUI({super.key, required this.videoPath, this.onlyPlayer = false});

  @override
  State<PlayerUI> createState() => _PlayerUIState();
}

class _PlayerUIState extends State<PlayerUI> {
  late Player _player;
  late VideoController controller;
  bool showAppbar = true;
  Timer? _hideTimer;
  FocusNode focus = FocusNode();
  @override
  void initState() {
    _player = Player(
      configuration: const PlayerConfiguration(bufferSize: 1024 * 1024),
    );
    controller = VideoController(_player);
    _player.open(Media(widget.videoPath));
    super.initState();
  }

  void _resetHideTimer() {
    _hideTimer?.cancel();
    setState(() {
      showAppbar = true;
    });
    _hideTimer = Timer(const Duration(seconds: 3), () {
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
    setState(() {});
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
              if (showAppbar && !widget.onlyPlayer)
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
    controller.player.stop();
    _player.dispose();
    focus.dispose();
    _hideTimer?.cancel();
    super.dispose();
  }
}
