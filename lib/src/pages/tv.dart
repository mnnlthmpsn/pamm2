import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pamm2/config.dart';
import 'package:better_player/better_player.dart';
import 'package:pamm2/generated/assets.dart';
import 'package:pamm2/helpers.dart';
import 'package:pamm2/src/components/countdown.dart';
import 'package:intl/intl.dart';
import 'package:pamm2/src/pages/tvFullScreen.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  Map<String, String> get _getDate {
    var temp = DateTime.now();
    var day = DateFormat('EEEE').format(temp);
    var date = DateFormat('d').format(temp);
    var month = DateFormat('MMMM').format(temp);
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
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: KColors.kLightColor),
          iconTheme: IconThemeData(color: KColors.kDarkColor),
          automaticallyImplyLeading: true,
          toolbarHeight: 40,
          backgroundColor: KColors.kLightColor,
          title: Row(
            children: [
              Text(
                'BROADCAST',
                style: TextStyle(
                    color: KColors.kDarkColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
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
              _comingUp,
              SizedBox(height: 8),
              _watchUs,
              SizedBox(height: 8),
              _connectWithUs,
              _support,
              SizedBox(height: MediaQuery.of(context).size.height * .1)
            ],
          ),
        ));
  }

  Widget get _nextLiveEvent {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(bottom: 10),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Next Live Event',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: KColors.kPrimaryColor)),
          FaIcon(FontAwesomeIcons.satelliteDish,
              size: 20, color: KColors.kPrimaryColor)
          // Icon(Icons.satellite_alt_rounded, size: 20, color: KColors.kPrimaryColor,)
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.withOpacity(.2)),
            bottom: BorderSide(color: Colors.grey.withOpacity(.2)),
            left: BorderSide(color: KColors.kPrimaryColor, width: 5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
    );
  }

  Widget get _comingUp {
    return Builder(builder: (BuildContext context) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.black54,
                        size: 15,
                      ),
                      SizedBox(width: 5),
                      Text(DateFormat('EEEE, d MMMM, yyyy')
                          .format(_getNextSunday))
                    ],
                  ),
                  Text('11:00 AM')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35.0),
              child: Text('Sunday Morning Service',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: KColors.kDarkColor)),
            ),
            SizedBox(height: 25),
            CountdownTimer(
              fullDuration: _duration,
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 8),
              child: Row(
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
                              "${DateFormat('d MMM, 11:00 ').format(_getNextSunday)}AM",
                              style: TextStyle(fontSize: 12)),
                          visible: _remind),
                      const SizedBox(width: 2),
                      Switch(
                          value: _remind,
                          onChanged: (value) => setReminder(value),
                          activeColor: Colors.white,
                          activeTrackColor: KColors.kPrimaryColor)
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_month_rounded,
                          color: KColors.kPrimaryColor),
                      const SizedBox(width: 10),
                      const Text('Add To Calendar')
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(Icons.share_rounded, color: KColors.kPrimaryColor),
                      const SizedBox(width: 10),
                      const Text('Share')
                    ],
                  )
                ],
              ),
            ),
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

  Widget get _watchUs {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Image.asset(Assets.imagesWatchUs),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 1), // changes position of shadow
          )
        ]));
  }

  Widget get _connectWithUs {
    List<Map<String, String>> socialLinks = [
      {
        'title': 'Facebook',
        'image': Assets.imagesFacebook,
        'link': 'https://facebook.com/prophetasantemensah'
      },
      {
        'title': 'Twitter',
        'image': Assets.imagesTwitter,
        'link': 'https://twitter.com/revasantemensah'
      },
      {
        'title': 'Tiktok',
        'image': Assets.imagesTikTok,
        'link': 'https://www.tiktok.com/@chrisasanteministries'
      },
      {
        'title': 'Youtube',
        'image': Assets.imagesYoutube,
        'link': 'https://www.youtube.com/channel/UCCawkgDRQGkkuOq9iMq75XQ'
      },
      {
        'title': 'Instagram',
        'image': Assets.imagesInstagram,
        'link': 'https://www.instagram.com/prophetasantemensah/'
      }
    ];

    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Text(
              'Connect with us',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: socialLinks
                  .map((e) => GestureDetector(
                      onTap: () => _launchInBrowser(Uri.parse(e['link']!)),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        width: 40,
                        height: 40,
                        child: Image.asset(
                          e['image']!,
                        ),
                      )))
                  .toList(),
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
              )
            ]));
  }

  Widget get _support {
    return Stack(
      children: [
        supportText,
        SizedBox(
          height: MediaQuery.of(context).size.height * .21,
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * .42,
          bottom: 2,
          child: donate,
        )
      ],
    );
  }

  Widget get supportText {
    return Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 8),
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
        child: Column(
          children: const [
            Text(
              "Please Support",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Chris Asante",
              style: TextStyle(fontSize: 18),
            ),
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
              )
            ]));
  }

  Widget get donate {
    return GestureDetector(
      onTap: () => newPage(context, 'give_2'),
      child: Container(
        padding: EdgeInsets.all(5),
        width: 60,
        height: 60,
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
            SizedBox(height: 1,),
            Text(
              'Donate',
              style: TextStyle(fontSize: 14, color: KColors.kPrimaryColor),
            )
          ],
        ),
      ),
    );
  }
}
