import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pamm2/config.dart';
import 'package:better_player/better_player.dart';
import 'package:pamm2/helpers.dart';
import 'package:pamm2/src/components/countdown.dart';
import 'package:intl/intl.dart';
import 'package:pamm2/src/pages/tvFullScreen.dart';

class TV extends StatefulWidget {
  const TV({Key? key}) : super(key: key);

  @override
  State<TV> createState() => _TVState();
}

class _TVState extends State<TV> {
  bool _remind = false;
  late final String date;
  String url =
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";

  void setReminder(bool val) {
    setState(() {
      _remind = val;
    });
  }

  Map<String, String> get _getDate {
    var temp = DateTime.now();
    var day = DateFormat('EEEE').format(temp);
    var date = DateFormat('d').format(temp);
    var month = DateFormat('MMM').format(temp);
    // DateFormat('EEEE, d MMM, yyyy')
    return {"day": day, "date": date, "month": month};
  }

  DateTime get _getNextSunday {
    DateTime today = DateTime.now();
    DateTime _firstDayOfTheweek =
        today.subtract(new Duration(days: today.weekday));
    DateTime _nextWeekSunday = _firstDayOfTheweek.add(Duration(days: 7));

    return _nextWeekSunday;
  }

  Duration get _duration {
    DateTime today = DateTime.now();
    DateTime _firstDayOfTheweek =
        today.subtract(new Duration(days: today.weekday));
    DateTime _nextWeekSunday =
        _firstDayOfTheweek.add(Duration(days: 7, hours: 8, minutes: 30));
    Duration _difference = _nextWeekSunday.difference(_firstDayOfTheweek);

    return _difference;
  }

  @override
  void initState() {
    // TODO: implement initState
    _getDate;
    _getNextSunday;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: KColors.kLightColor),
            automaticallyImplyLeading: false,
            toolbarHeight: 120,
            backgroundColor: KColors.kDarkColor,
            title: Container(
              height: MediaQuery.of(context).size.height * .15,
              color: KColors.kDarkColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * .3,
                      child: Image.asset(
                        'assets/images/logo.png',
                        color: Colors.white,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("${_getDate["day"]!},",
                              style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600)),
                          Text(_getDate["month"]!,
                              style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600))
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        _getDate["date"]!,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                TVFullScreen(url: url))),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: BetterPlayer.network(
                          url,
                          betterPlayerConfiguration:
                              const BetterPlayerConfiguration(
                                  autoDetectFullscreenAspectRatio: true,
                                  aspectRatio: 16 / 9,
                                  autoPlay: true,
                                  controlsConfiguration:
                                      BetterPlayerControlsConfiguration(
                                          enableSubtitles: false,
                                          enableQualities: false,
                                          enableAudioTracks: false,
                                          showControls: false)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .03),
                _nextLiveEvent,
                _comingUp
              ],
            ),
          )),
    );
  }

  Widget get _nextLiveEvent {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Next Live Event', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: KColors.kPrimaryColor),),
          FaIcon(FontAwesomeIcons.satelliteDish, size: 20, color: KColors.kPrimaryColor)
          // Icon(Icons.satellite_alt_rounded, size: 20, color: KColors.kPrimaryColor,)
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.withOpacity(.2)),
          bottom: BorderSide.none,
          left: BorderSide(color: KColors.kPrimaryColor, width: 5),
        ),
      ),
    );
  }

  Widget get _comingUp {
    return Builder(builder: (BuildContext context) {
      return Container(
        margin: EdgeInsets.only(right: 8, left: 8),
        padding: EdgeInsets.all(15),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.notifications,
                      color: KColors.kPrimaryColor,
                      size: 15,
                    ),
                    SizedBox(width: 5),
                    Text(DateFormat('EEEE, d MMMM, yyyy').format(_getNextSunday))
                  ],
                ),
                Text('11:00 AM')
              ],
            ),
            SizedBox(height: 15),
            Text('Sunday Morning Live Service',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: KColors.kDarkColor)),
            SizedBox(height: 25),
            CountdownTimer(
              fullDuration: _duration,
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(Icons.notifications, color: KColors.kPrimaryColor),
                    const SizedBox(width: 10),
                    const Text('Remind')
                  ],
                ),
                Row(
                  children: [
                    Visibility(
                        child: Text(
                            DateFormat('EEEE, d MMMM').format(_getNextSunday)),
                        visible: _remind),
                    const SizedBox(width: 5),
                    Switch(
                        value: _remind,
                        onChanged: (value) => setReminder(value),
                        activeColor: KColors.kPrimaryColor,
                        activeTrackColor: Colors.grey.withOpacity(.6))
                  ],
                )
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
      );
    });
  }
}
