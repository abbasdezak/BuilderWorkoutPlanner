import 'dart:io';
import 'dart:typed_data';

import 'package:builderworkoutplanner/models/exercise_model.dart';
import 'package:builderworkoutplanner/models/time_helper.dart';
import 'package:builderworkoutplanner/models/youtube_controller.dart';
import 'package:builderworkoutplanner/pages/congrat_page.dart';
import 'package:builderworkoutplanner/pages/rest_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WorkoutPage extends StatefulWidget {
  final List? workoutNameLists;

  const WorkoutPage(
      {Key? key,  this.workoutNameLists})
      : super(key: key);

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  YoutubePlayerController? _controller;
  int currentExercise = 0;
  Map workoutData = {};
  List<Company>? data;
  // List<Map<String,dynamic>> maps = [{''}];

  @override
  void dispose() {
    _controller!.dispose();
    _controller = null;
    super.dispose();
  }

  void _initController() {
    if (currentExercise == 0) {
      _controller =
          YoutubeController(address: '${data![currentExercise].imgurl}')
              .ytController();
    }
  }

  @override
  void initState() {
    print('currexe\n $currentExercise \n');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: dbInit(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print('snapshot Eroor : \n ${snapshot.error}');
          if (snapshot.hasData) {
            // currentExercise = widget.currentIndex??0;

            data = snapshot.data;
            double linearValue = (currentExercise + 1) / data!.length;

            _initController();
            return Scaffold(
              body: widgets(size, context, linearValue),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Stack widgets(Size size, BuildContext context, double linearValue) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: size.height * .026,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: EdgeInsets.all(15),
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios))),
                Container(
                    margin: EdgeInsets.all(15),
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          // showDiolog(context, data);
                        },
                        icon: Icon(Icons.more_horiz))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: size.width * .6,
                  child: Text('${data![currentExercise].name}',
                      style: TextStyle(
                          fontSize: size.height * .025,
                          fontWeight: FontWeight.bold)),
                ),
                Text('${currentExercise + 1}/${data!.length}',
                    style: TextStyle(
                        fontSize: size.height * .038,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(
              height: size.height * .025,
            ),
            Container(
              width: size.width * .835,
              height: size.height * 0.025,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.blue[50]!,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.blue[400]!,
                  ),
                  value: linearValue,
                ),
              ),
            ),
            SizedBox(
              height: size.height * .13,
            ),
            Container(
              width: size.width * .9,
              alignment: Alignment.center,
              child: YoutubePlayer(
                  controller: _controller!, enableToggleFullScreenMode: false),
            )
          ],
        ),
        Positioned(
          bottom: size.height * 0.025,
          right: size.height * .05,
          left: size.height * .05,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.blue.withOpacity(0.07),
              ),
              height: 142,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildText(
                        title: 'Sets',
                        value: '${workoutData['Sets']} times',
                      ),
                      buildText(
                        title: 'Reps',
                        value: '${workoutData['Reps']} times',
                      ),
                    ],
                  ),
                  buildButtons(context, data!.length, size),
                ],
              )),
        )
      ],
    );
  }

  Future dbInit() async {
    workoutData = await TimeHelper.dataGetter('Settings', 'Setting');
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "x.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

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
    } else {
      print("Opening existing database");
    }
    final db = await openDatabase(path);

    final List<Map<String, dynamic>> maps = await db.query('COMPANY');

    List<Company> mapToList = List.generate(maps.length, (index) {
      return Company(
        id: index,
        ischeck: 0,
        name: maps[index]['NAME'],
        imgurl: (maps[index]["IMGURL"] != null) ? maps[index]["IMGURL"] : '',
      );
    });
    List<Company> wrkts = List.generate(
        widget.workoutNameLists!.length,
        (index) => Company(
              id: index,
              ischeck: 0,
              name: widget.workoutNameLists![index],
              imgurl: mapToList
                      .firstWhere(
                          (e) => e.name == widget.workoutNameLists![index])
                      .imgurl ??
                  " ",
            ));
    return wrkts;
  }

  Widget buildText({
    required String title,
    required String value,
  }) =>
      Column(
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.black54),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      );

  Widget buildButtons(BuildContext context, int totalIndex, size) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          (currentExercise > 0)
              ? IconButton(
                  icon: Icon(
                    Icons.fast_rewind,
                    color: Colors.black87,
                    size: 32,
                  ),
                  onPressed: () async {
                    currentExercise--;
                    setState(() {});

                    String vidId = YoutubePlayer.convertUrlToId(
                            data![currentExercise].imgurl.toString())
                        .toString();
                    _controller!.load(vidId);
                  },
                )
              : Center(),
          IconButton(
            icon: Icon(
              Icons.fast_forward,
              color: Colors.black87,
              size: 32,
            ),
            onPressed: () async {
              List<Company> _data = await dbInit();
              if (currentExercise >= _data.length - 1) {
                TimeHelper.workoutSaver();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return CongratPage();
                }));
              } else {
                currentExercise++;
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => RestPage(
                              currentIndex: currentExercise,
                              totalIndex: data!.length,
                              nextExerciseName: data![currentExercise].name,
                            ))));
                setState(() {});
                String vidId = YoutubePlayer.convertUrlToId(
                        data![currentExercise].imgurl.toString())
                    .toString();
                _controller!.load(vidId);

                // _controller!.dispose();

              }
            },
          ),
        ],
      );

  Widget buildButton(
    BuildContext context, {
    required Widget icon,
    required VoidCallback onClicked,
  }) =>
      GestureDetector(
        onTap: onClicked,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0xFFff6369),
                blurRadius: 8,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 24,
            backgroundColor: Color(0xFFff6369),
            child: icon,
          ),
        ),
      );
}
