import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';

class CountdownTimer extends StatefulWidget {
  final Duration fullDuration;

  const CountdownTimer({Key? key, required this.fullDuration})
      : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer? countdownTimer;
  Duration myDuration = Duration(days: 5);

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() => myDuration = widget.fullDuration);
    startTimer();
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = widget.fullDuration);
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    final seconds = myDuration.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      countdownTimer!.cancel();
    } else {
      setState(() {
        myDuration = Duration(seconds: seconds);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(myDuration.inDays);
    // Step 7
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Row(
              children: [
                _counterContainer(days[0]),
                _counterContainer(days[1]),
              ],
            ),
            SizedBox(height: 8),
            Text('Days', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14, color: Colors.grey),)
          ],
        ),
        SizedBox(width: MediaQuery.of(context).size.width * .01),
        Column(
          children: [
            Row(
              children: [
                _counterContainer(hours[0]),
                _counterContainer(hours[1]),
              ],
            ),
            SizedBox(height: 8),
            Text('Hours', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14, color: Colors.grey),)
          ],
        ),
        SizedBox(width: MediaQuery.of(context).size.width * .01),
        Column(
          children: [
            Row(
              children: [
                _counterContainer(minutes[0]),
                _counterContainer(minutes[1]),
              ],
            ),
            SizedBox(height: 8),
            Text('Minutes', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14, color: Colors.grey),)
          ],
        ),
        SizedBox(width: MediaQuery.of(context).size.width * .01),
        Column(
          children: [
            Row(
              children: [
                _counterContainer(seconds[0]),
                _counterContainer(seconds[1]),
              ],
            ),
            SizedBox(height: 8),
            Text('Seconds', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14, color: Colors.grey),)
          ],
        ),
      ],
    );
  }

  Widget _counterContainer(value) {
    return Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * .1,
        decoration: BoxDecoration(
            color: KColors.kDarkColor, borderRadius: BorderRadius.circular(2)),
        margin: EdgeInsets.all(.3),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7),
              child: Text(
                value,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 40),
              ),
            ),
            const Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Divider(color: Colors.white, thickness: 1))
          ],
        ));
  }
}
