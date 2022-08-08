import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:builderworkoutplanner/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:builderworkoutplanner/pages/details_page.dart';
import 'package:get/get.dart';
import 'data.dart';
import 'models/time_helper.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // <-- Adding this line to initialize my app first
  runApp(MyApp());
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
    precacheImage(AssetImage("assets/images/details_image.jpg"), context);
    precacheImage(AssetImage("assets/images/empty.jpg"), context);
    precacheImage(AssetImage("assets/images/first_page.jpg"), context);
    precacheImage(AssetImage("assets/images/height.jpg"), context);

// SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        fontFamily: 'Josefin Sans',
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Color(firstColor)),
      ),
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
  bool _isLoaded = false;

  _loadChcekcer() async {
    data = await TimeHelper.dataGetter('Settings', 'Setting');

    _timer = Timer(const Duration(seconds: 2), () {
      setState(() {
        _isLoaded = true;
      });
      if (data.isNotEmpty) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => DetailsPage()));
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
    return splashScren(size);
  }

  Stack splashScren(Size size) {
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
