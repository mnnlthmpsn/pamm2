import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee/marquee.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/generated/assets.dart';
import 'package:pamm2/src/models/programme.dart';
import 'package:pamm2/src/repos/programmeRepo.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../helpers.dart';

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
  late Future<List<DayModel>> myFuture;

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
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black),
        elevation: 0,
        automaticallyImplyLeading: true,
        foregroundColor: KColors.kDarkColor,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset(
          'assets/images/coga_radio.png',
          height: 80,
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            _radialGauge,
            Positioned(
              bottom: 0,
              top: 0,
              left: 0,
              right: 0,
              child: _playerBuffer,
            )
          ],
        ),
        _support
      ],
    );
  }

  Widget get _playerBuffer {
    return PlayerBuilder.isBuffering(
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
        });
  }

  Widget get _radialGauge {
    return SfRadialGauge(
      title: GaugeTitle(
          text: _isChanging == true
              ? 'Vol ${_volumeValue.ceil().toString()} %'
              : ''),
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
                      border: Border.all(color: KColors.kLightColor, width: .5),
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
    );
  }

  Widget get _support {
    return Column(
      children: [supportText, const SizedBox(height: 25), donate],
    );
  }

  Widget get supportText {
    return Container(
        margin: EdgeInsets.only(left: 15, right: 15),
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: const [
            Text(
              "Please Support",
              style: TextStyle(fontSize: 14),
            ),
            Text(
              "Chris Asante",
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ));
  }

  Widget get donate {
    return GestureDetector(
      onTap: () => newPage(context, 'give_2'),
      child: Container(
        padding: EdgeInsets.all(5),
        width: 65,
        height: 65,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(45),
            boxShadow: [
              BoxShadow(
                color: KColors.kDarkColor.withOpacity(.2),
                spreadRadius: 6,
                blurRadius: 6,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Assets.iconsGive2,
              height: 18,
              width: 22,
            ),
            SizedBox(
              height: 1,
            ),
            Text(
              'Donate',
              style: TextStyle(fontSize: 12, color: KColors.kPrimaryColor),
            )
          ],
        ),
      ),
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
    return FutureBuilder<List<DayModel>>(
        future: myFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            List<DayModel> days = snapshot.data;
            return ListView.builder(
                itemCount: days.length,
                itemBuilder: (BuildContext context, int i) {
                  return Column(
                    children: [
                      GFAccordion(
                          margin: const EdgeInsets.all(0),
                          titlePadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          expandedTitleBackgroundColor: Colors.white,
                          titleChild: Text(
                              days[i].title,
                              style: TextStyle(
                                  color: KColors.kPrimaryColor, fontSize: 22)),
                          collapsedIcon: Icon(Icons.add_circle_outline_outlined,
                              color: KColors.kPrimaryColor, size: 26),
                          expandedIcon: Icon(Icons.remove_circle_outline,
                              color: KColors.kPrimaryColor, size: 26),
                          contentChild: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: days[i].programmes.isEmpty
                                ? const Text('No programmes for this day')
                                : ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: days[i].programmes.length,
                                    itemBuilder: (BuildContext context, int j) {
                                      return Row(
                                        children: [
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  days[i].programmes[j].title,
                                                  style:
                                                      const TextStyle(fontSize: 18)),
                                              Text(days[i].programmes[j].time)
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
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                  child: Text('An error occurred getting Radio Schedule',
                      style: TextStyle(fontSize: 16))),
            );
          }

          return Center(
            child: Lottie.asset('assets/lottie/loader.json'),
          );
        });
  }
}
