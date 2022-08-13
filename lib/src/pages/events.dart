import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/src/components/drawer.dart';

class Events extends StatelessWidget {
  final String? src;

  const Events({Key? key, this.src}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: src == null ? _appBar() : _invincible(),
        body: _tabController());
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
        backgroundColor: KColors.kPrimaryColor,
        title: const Text(
          'Events',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ));
  }

  PreferredSizeWidget _invincible() {
    return AppBar(toolbarHeight: 0);
  }

  Widget _tabController() {
    return DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            Container(
              color: KColors.kLightColor.withOpacity(.6),
              child: TabBar(
                indicatorColor: KColors.kPrimaryColor,
                labelColor: KColors.kPrimaryColor,
                unselectedLabelColor: KColors.kDarkColor,
                labelStyle: const TextStyle(fontSize: 14),
                tabs: <Widget>[
                  Tab(
                    height: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'UPCOMING'
                        ),
                        Text(
                          'EVENTS'
                        )
                      ],
                    ),
                  ),
                  const Tab(
                    text: 'PAST EVENTS',
                    height: 60,
                  ),
                  const Tab(
                    text: 'LIVE EVENTS',
                    height: 60,
                  )
                ],
              ),
            ),
            _tabBody()
          ],
        ));
  }

  Widget _tabBody() {
    return Expanded(
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[_upcoming(), _past(), _live()],
      ),
    );
  }

  Widget _upcoming() {
    return Center(child: Text('Upcoming Events'));
  }

  Widget _past() {
    return Center(child: Text('Past Events'));
  }

  Widget _live() {
    return Center(child: Text('Live Events'));
  }
}
