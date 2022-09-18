import 'dart:async';
import 'dart:ui';
import 'package:builderworkoutplanner/app/core/model/time_helper.dart';
import 'package:builderworkoutplanner/app/core/values/theme.dart';
import 'package:builderworkoutplanner/app/data/local/preference/prefs.dart';
import 'package:builderworkoutplanner/app/modules/introduction/controllers/intro_controller.dart';
import 'package:builderworkoutplanner/app/modules/introduction/views/intro_view.dart';
import 'package:builderworkoutplanner/app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // <-- Adding this line to initialize my app first
  SharedPreferences.getInstance().then((SharedPreferences sp) {
    Prefs.setPrefs(sp);
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  MyApp({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
// SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      title: 'Auth page',
      home: Scaffold(body: SplashScreen()),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  Map data = {};
  IntroController introController = Get.put(IntroController());

  _loadChcekcer() async {
    _timer = Timer(const Duration(seconds: 2), () {
      if (introController.isInitiated.value == true) {
        Get.to(
            HomePage(
              currIndex: 1,
            ),
            transition: Transition.cupertino,
            duration: Duration(seconds: 3));
      } else {
        Get.to(IntroView(),
            transition: Transition.cupertino, duration: Duration(seconds: 2));
      }
    });
  }

  @override
  void initState() {
    _loadChcekcer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/first_page.jpg"),
            fit: BoxFit.cover,
          )),
          child: new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: new Container(
              decoration:
                  new BoxDecoration(color: Colors.white.withOpacity(0.0)),
            ),
          ),
        ),
        Positioned(
            top: size.height * .09,
            left: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello There',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '\nStay Fit,Stay Strong.',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: size.height * .024,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )),
      ],
    );
  }
}
