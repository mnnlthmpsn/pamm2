import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee/marquee.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/src/repos/programmeRepo.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class IRadio extends StatefulWidget {
  const IRadio({Key? key}) : super(key: key);

  @override
  State<IRadio> createState() => _IRadioState();
}

class _IRadioState extends State<IRadio> {
  double _volumeValue = 80;
  bool _isChanging = false;

  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
  final ProgrammeRepo programmeRepo = ProgrammeRepo();
  late Future myFuture;

  @override
  void initState() {
    super.initState();
    openPlayer();
    myFuture = programmeRepo.getProgrammes();
  }

  void openPlayer() async {
    try {
      _assetsAudioPlayer.setVolume(0.8);
      await _assetsAudioPlayer.open(
          Audio.liveStream('http://stream.zeno.fm/v4yadutfvnhvv'),
          autoStart: true);
    } catch (e) {
      print(e);
      print('error playing radio');
    }
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    _assetsAudioPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: _body(),
    );
  }

  void onVolumeChange(double val) {
    setState(() {
      _isChanging = true;
      _volumeValue = val;
      _assetsAudioPlayer.setVolume(val.ceil() / 100);
    });
  }

  void onVolumeChangeEnd(val) {
    setState(() => _isChanging = false);
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        foregroundColor: KColors.kDarkColor,
        backgroundColor: Colors.white,
        title: const Text(
          'iRadio',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ));
  }

  Widget _body() {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              color: KColors.kLightColor.withOpacity(.6),
              child: TabBar(
                unselectedLabelColor: KColors.kDarkColor,
                labelStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                indicator: BoxDecoration(color: KColors.kPrimaryColor),
                tabs: const <Widget>[
                  Tab(
                    text: 'Now Playing',
                    height: 50,
                  ),
                  Tab(
                    text: 'Schedule',
                    height: 50,
                  )
                ],
              ),
            ),
            _tabController()
          ],
        ));
  }

  Widget _tabController() {
    return Expanded(
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[_nowPlaying(), _schedule()],
      ),
    );
  }

  Widget _nowPlaying() {
    return Stack(
      children: <Widget>[
        Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                _isChanging == true
                    ? 'Vol ${_volumeValue.ceil().toString()} %'
                    : '',
                style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: KColors.kPrimaryColor),
              ),
            )),
        Positioned(
          top: MediaQuery.of(context).size.height * .06,
          left: 0,
          right: 0,
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 100,
                startAngle: 270,
                endAngle: 270,
                showLabels: false,
                showTicks: false,
                radiusFactor: .55,
                axisLineStyle: AxisLineStyle(
                    cornerStyle: CornerStyle.bothFlat,
                    color: Colors.black12.withOpacity(.06),
                    thickness: 5),
                pointers: <GaugePointer>[
                  RangePointer(
                      value: _volumeValue,
                      cornerStyle: CornerStyle.bothFlat,
                      width: 5,
                      sizeUnit: GaugeSizeUnit.logicalPixel,
                      color: Colors.orangeAccent,
                      gradient: const SweepGradient(
                          colors: <Color>[Color(0XFFF9D405), Color(0XFFF93505)],
                          stops: <double>[0.25, 0.75])),
                  WidgetPointer(
                    value: _volumeValue,
                    enableDragging: true,
                    onValueChanged: (val) => onVolumeChange(val),
                    onValueChangeEnd: (val) => onVolumeChangeEnd(val),
                    child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffE7E9E8),
                            border: Border.all(
                                color: KColors.kLightColor, width: .5),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12.withOpacity(.2),
                                  spreadRadius: .8,
                                  blurRadius: .8,
                                  offset: const Offset(1, 2))
                            ]),
                        padding: const EdgeInsets.all(3),
                        child: const Icon(
                          Icons.volume_up_outlined,
                          size: 18,
                          color: Colors.black45,
                        )),
                  )
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * .27,
          right: 0,
          left: 0,
          child: PlayerBuilder.isBuffering(
              player: _assetsAudioPlayer,
              builder: (BuildContext context, bool isbuffering) {
                if (isbuffering) {
                  return _bufferingIcon();
                } else {
                  return PlayerBuilder.isPlaying(
                      player: _assetsAudioPlayer,
                      builder: (BuildContext context, bool isPlaying) {
                        return isPlaying ? _pauseButton() : _playButton();
                      });
                }
              }),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 50,
              color: KColors.kLightColor,
              child: Center(
                  child: Marquee(
                text: 'Welcome to CAM iRadio',
                style: TextStyle(fontSize: 14),
                blankSpace: 80,
                velocity: 30,
              )),
            ))
      ],
    );
  }

  Widget _playButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () => _assetsAudioPlayer.playOrPause(),
            child: Icon(Icons.play_arrow_rounded,
                size: 50, color: KColors.kPrimaryColor)),
        Text(
          'PLAY',
          style: TextStyle(color: KColors.kPrimaryColor, fontSize: 12),
        )
      ],
    );
  }

  Widget _pauseButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () => _assetsAudioPlayer.playOrPause(),
            child: Icon(Icons.pause_rounded,
                size: 50, color: KColors.kPrimaryColor)),
        Text('PAUSE',
            style: TextStyle(color: KColors.kPrimaryColor, fontSize: 12))
      ],
    );
  }

  Widget _bufferingIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(color: KColors.kPrimaryColor, strokeWidth: 2),
        const SizedBox(height: 15),
        Text('BUFFERING',
            style: TextStyle(color: KColors.kPrimaryColor, fontSize: 12))
      ],
    );
  }

  Widget _schedule() {
    return FutureBuilder(
        future: myFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            dynamic programmes = snapshot.data;
            return ListView.builder(
                itemCount: programmes.length,
                itemBuilder: (BuildContext context, int i) {
                  return Column(
                    children: [
                      GFAccordion(
                          margin: EdgeInsets.all(0),
                          titlePadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          expandedTitleBackgroundColor: Colors.white,
                          titleChild: Text(
                              programmes[i]['attributes']['title']!,
                              style: TextStyle(
                                  color: KColors.kPrimaryColor, fontSize: 22)),
                          collapsedIcon: Icon(Icons.add_circle_outline_outlined,
                              color: KColors.kPrimaryColor, size: 26),
                          expandedIcon: Icon(Icons.remove_circle_outline,
                              color: KColors.kPrimaryColor, size: 26),
                          contentChild: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: programmes.isEmpty
                                ? Text('No programmes for this day')
                                : ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: programmes[i]['attributes']
                                            ['programmes']['data']
                                        .length,
                                    itemBuilder: (BuildContext context, int j) {
                                      return Row(
                                        children: [
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  programmes[i]['attributes']
                                                              ['programmes']
                                                          ['data'][j]
                                                      ['attributes']['title']!,
                                                  style:
                                                      TextStyle(fontSize: 18)),
                                              Text(programmes[i]['attributes']
                                                          ['programmes']['data']
                                                      [j]['attributes']['time']
                                                  .toString())
                                            ],
                                          )),
                                          const SizedBox(width: 24),
                                          Column(
                                            children: [
                                              Switch.adaptive(
                                                  value: false,
                                                  onChanged: (val) {}),
                                              Text('Remind me',
                                                  style: TextStyle(
                                                      color: KColors
                                                          .kPrimaryColor))
                                            ],
                                          )
                                        ],
                                      );
                                    }),
                          )),
                      const Divider()
                    ],
                  );
                });
          }

          if (snapshot.hasError) {
            return const Center(
                child: Text('An error occured getting Radio Schedule',
                    style: TextStyle(fontSize: 22)));
          }

          return Center(
            child: Lottie.asset('assets/lottie/loader.json'),
          );
        });
  }
}
