import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';

class TVFullScreen extends StatelessWidget {

  final String url;
  final String _url =
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";

  const TVFullScreen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      backgroundColor: Colors.black,
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: BetterPlayer.network(
            _url,
            betterPlayerConfiguration:
            const BetterPlayerConfiguration(
                autoDetectFullscreenAspectRatio: true,
                aspectRatio: 16 / 9,
                autoPlay: true,
                fullScreenByDefault: true,
                controlsConfiguration:
                BetterPlayerControlsConfiguration(
                    enableSubtitles: false,
                    enableQualities: false,
                    enableAudioTracks: false,
                    showControls: true)),
          ),
        ),
      ),
    );
  }
}
