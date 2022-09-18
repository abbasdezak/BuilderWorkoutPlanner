import 'dart:io';
import 'package:builderworkoutplanner/app/modules/statics/views/stats_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'modules/home/views/home_view.dart';
import 'modules/settings/views/settings_view.dart';

class HomePage extends StatefulWidget {
  final int? currIndex;
  const HomePage({Key? key, this.currIndex}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndext = 1;
  List<Widget> bars = [StatsPage(), HomeView(), SettingsPage()];
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    initializeDatabase();
    setState(() {
      if (widget.currIndex != null) {
        currentIndext = widget.currIndex!;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        bottomNavigationBar: _bottomNavBar(), body: bars[currentIndext]);
  }

  _bottomNavBar() {
    return Container(
      height: 55,
      child: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[500],
        type: BottomNavigationBarType.shifting,
        showSelectedLabels: false,
        currentIndex: currentIndext,
        onTap: (value) {
          setState(() {
            currentIndext = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
              size: 20,
            ),
            label: "Stats",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 20,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 20,
            ),
            label: "Settings",
          ),
        ],
      ),
    );
  }
  Future initializeDatabase() async {
    var databasesPath = await getDatabasesPath();

    var path = join(databasesPath, "x.db");
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "db/x.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    }
  }
}
