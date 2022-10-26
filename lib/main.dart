import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pamm2/config.dart';
import 'package:pamm2/src/pages/Give.dart';
import 'package:pamm2/src/pages/Home.dart';
import 'package:pamm2/src/pages/about.dart';
import 'package:pamm2/src/pages/annex/event_nav.dart';
import 'package:pamm2/src/pages/annex/store_nav.dart';
import 'package:pamm2/src/pages/archives.dart';
import 'package:pamm2/src/pages/bible.dart';
import 'package:pamm2/src/pages/billing.dart';
import 'package:pamm2/src/pages/drawer/contact.dart';
import 'package:pamm2/src/pages/drawer/prayer.dart';
import 'package:pamm2/src/pages/drawer/testimony.dart';
import 'package:pamm2/src/pages/annex/give_nav.dart';
import 'package:pamm2/src/pages/eStore.dart';
import 'package:pamm2/src/pages/iRadio.dart';
import 'package:pamm2/src/pages/login.dart';
import 'package:pamm2/src/pages/pama.dart';
import 'package:pamm2/src/pages/partner.dart';
import 'package:pamm2/src/pages/social.dart';
import 'package:pamm2/src/pages/splashScreen.dart';
import 'package:pamm2/src/pages/tv.dart';
import 'package:pamm2/src/pages/welcome.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(KTextTheme.textTheme),
        inputDecorationTheme: TextFieldTheme.textFieldTheme,
        primaryColor: KColors.kPrimaryColor,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: KColors.kLightColor),
      ),
      initialRoute: 'splash',
      routes: {
        '/': (context) => const Welcome(),
        'splash': (context) => const SplashScreen(),
        'home': (context) => const Home(),
        'archives': (context) => const Archives(),
        'about': (context) => const About(),
        'bible': (context) => const Bible(),
        'billing': (context) => const Billing(),
        'give': (context) => const Give(),
        'give_2': (context) => const GiveAnnex(),
        'login': (context) => const Login(),
        'radio': (context) => const IRadio(),
        'tv': (context) => const TV(),
        'pama': (context) => const PAMA(),
        'partner': (context) => const Partner(),
        'store': (context) => const Store(),
        'store_2': (context) => const StoreAnnex(),
        'social': (context) => const Social(),

        //  drawer routes
        'testimony': (context) => const Testimony(),
        'prayer': (context) => const Prayer(),
        'events_2': (context) => const EventAnnex(),
        'contact': (context) => const Contact()
      },
    );
  }
}
