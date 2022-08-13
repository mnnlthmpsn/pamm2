import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pamm2/config.dart';
import 'package:better_player/better_player.dart';

class TV extends StatefulWidget {
  const TV({Key? key}) : super(key: key);

  @override
  State<TV> createState() => _TVState();
}

class _TVState extends State<TV> {
  // late VideoPlayerController _controller;
  // late Future<void> _initializeVIdeoPlayerFuture;
  //
  String url =
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  //   _controller = VideoPlayerController.network(url);
  //   _initializeVIdeoPlayerFuture = _controller.initialize();
  // }
  //
  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
            height: MediaQuery.of(context).size.height * .15,
              color: KColors.kPrimaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 76,
                      child: Image.asset('assets/images/logo.png', color: Colors.white,)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Thursday,', style: TextStyle(color: Colors.white, fontSize: 22),),
                          Text('August', style: TextStyle(color: Colors.white, fontSize: 22),)
                        ],
                      ),
                      SizedBox(width: 10,),
                      Text('4', style: TextStyle(color: Colors.white, fontSize: 62, fontWeight: FontWeight.bold),)
                    ],
                  )
                ],
              ),
            ),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer.network(
                  url,
                  betterPlayerConfiguration: const BetterPlayerConfiguration(
                    autoDetectFullscreenAspectRatio: true,
                    aspectRatio: 16 / 9,
                    controlsConfiguration: BetterPlayerControlsConfiguration(
                      enableSubtitles: false,
                      enableQualities: false,
                      enableAudioTracks: false
                    )
                  ),
              ),
            )
          ],
        ));
  }
}
