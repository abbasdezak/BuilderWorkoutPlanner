import 'dart:convert';

import 'package:builderworkoutplanner/data.dart';
import 'package:builderworkoutplanner/models/exercise_model.dart';
import 'package:builderworkoutplanner/models/get_controller.dart';
import 'package:builderworkoutplanner/models/json_plans_model.dart';
import 'package:builderworkoutplanner/models/tab_models.dart';
import 'package:builderworkoutplanner/pages/app_plans_page.dart';
import 'package:builderworkoutplanner/pages/home_page.dart';
import 'package:builderworkoutplanner/widgets/add_sets.dart';
import 'package:builderworkoutplanner/widgets/bottom_popup.dart';
import 'package:builderworkoutplanner/widgets/linked_label_check_box.dart';
import 'package:builderworkoutplanner/widgets/listview_card.dart';
import 'package:builderworkoutplanner/widgets/rounded_text_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../data.dart';
import '../models/prefs.dart';
import 'add_exercise_page.dart';
import 'package:path/path.dart';

class secondPage extends StatefulWidget {
  final tableName;
  const secondPage({Key? key, this.tableName}) : super(key: key);

  @override
  _secondPageState createState() => _secondPageState();
}

class _secondPageState extends State<secondPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameControler =
      new TextEditingController(text: 'My Random Plan 1');
  List<Tabs> tabWidgets = [];
  List<int> tabNames = [];
  ExerciseController _exerciseController = Get.put(ExerciseController());

  @override
  void initState() {
    tabNames.add(1);
    tabWidgets.add(Tabs(name: " ", wrkts: []));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    Future<bool> _onWillPop() async {
      return (await showDialog(
            builder: (context) => AlertDialog(
              title: Text(
                'Are you sure?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(
                'Want to return back?\nAll data will be lost!',
                style: TextStyle(fontSize: size.width * .045),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Yes'),
                ),
              ],
            ),
            context: context,
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: DefaultTabController(
        length: tabNames.length,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 0, 32, 80),
          appBar: _appBar(context),
          body: TabBarView(
            children: tabWidgets.map((e) {
              return widgets(context, size,
                  tabWidgets.indexWhere((element) => element == e));
            }).toList(),
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Color.fromARGB(255, 0, 32, 80),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20),
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              // if (_exercoseController.selectedExercises.isNotEmpty) {
              //   Get.to(() => secondPage());
              // } else {
              //   Get.snackbar('Required', 'At least one exercise required !',
              //       snackPosition: SnackPosition.BOTTOM,
              //       backgroundColor: Colors.grey[100],
              //       icon: Icon(
              //         Icons.warning,
              //         color: Colors.red,
              //       ),
              //       margin: EdgeInsets.all(20));
              // }
            },
            child: Text(
              'Next',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Stack widgets(BuildContext context, Size size, int indexTab) {
    return Stack(children: [
      Column(
        children: [
          Container(
            height: size.height * .15,
            width: size.width,
            margin: EdgeInsets.only(top: size.height * .02, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Sets',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: size.height * .06,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Workout creation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.height * .024,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _listView(size))
        ],
      ),
    ]);
  }

  _listView(Size size) {
    return Obx(() {
      var exrcs = _exerciseController.selectedExercises;
      return Container(
        color: Colors.grey[100],
        child: ListView.builder(
            itemCount: exrcs.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: AddSets(
                  exerciseImage: exrcs[index].imgurl!,
                  exerciseName: exrcs[index].name,
                  sets: exrcs[index].sets ?? [],
                  onAddSet: () => _exerciseController.planDetailes(
                      exrcs[index].sets.length ?? 0, Sets(1)),
                ),
              );
            }),
      );
    });
  }

  onSaved(BuildContext context) async {
    if (_nameControler.text == '') {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Plan's name can't be empty!")));
    } else if (tabWidgets[0].wrkts!.length == 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Plan can't be empty!")));
    } else {
      for (var name in tabNames) {
        tabWidgets[name - 1].name = 'Day $name';
      }
      await Prefs()
          .saveData(name: '${_nameControler.text}', splits: tabWidgets);

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return HomePage();
      }));
    }
  }

  // planAdder(context) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   List<Plans>? _oldData;

  //   try {
  //     String? plans = await prefs.getString('plans');
  //     _oldData = JsonPlansModel.fromJson(jsonDecode(plans!)).plans;

  //     _oldData!.add(Plans(
  //         name: "${_nameControler.text}",
  //         splits: tabWidgets
  //             .map((e) => Splits(
  //                 imgUrl: "",
  //                 exrcs: e.wrkts!.map((e) => "${e.name}").toList(),
  //                 name: "${e.name}"))
  //             .toList()));
  //     var json = JsonPlansModel(plans: _oldData).toJson();
  //     await prefs.setString('plans', jsonEncode(json));
  //   } catch (e) {
  //     _oldData!.add(Plans(
  //         name: "${_nameControler.text}",
  //         splits: tabWidgets
  //             .map((e) => Splits(
  //                 imgUrl: "",
  //                 exrcs: e.wrkts!.map((e) => "${e.name}").toList(),
  //                 name: "${e.name}"))
  //             .toList()));
  //     var json = JsonPlansModel(plans: _oldData).toJson();
  //     await prefs.setString('plans', jsonEncode(json));
  //   }
  // }
}






  // _appBar(Size size, BuildContext context) async {
  //   return AppBar(
  //       backgroundColor: Colors.blue[400],
  //       bottom: TabBar(
  //           indicatorColor: Colors.white,
  //           isScrollable: true,
  //           tabs: tabNames
  //               .map(
  //                 (e) => Tab(
  //                   child: Row(children: [
  //                     Text(
  //                       'Day $e',
  //                       style: TextStyle(
  //                           color: Colors.white,
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: size.height * .025),
  //                     ),
  //                     (tabNames.length > 1)
  //                         ? Container(
  //                             width: size.width * .05,
  //                             child: IconButton(
  //                                 onPressed: () {
  //                                   tabNames.remove(e);
  //                                   tabWidgets.removeAt(e - 1);

  //                                   tabNames = List.generate(
  //                                       tabNames.length, (index) => index + 1);

  //                                   setState(() {});
  //                                 },
  //                                 icon: Icon(
  //                                   Icons.close,
  //                                   color: Colors.white,
  //                                   size: size.width * .05,
  //                                 )),
  //                           )
  //                         : Center(),
  //                   ]),
  //                 ),
  //               )
  //               .toList()),
  //       actions: [
  //         Container(
  //           margin: EdgeInsets.only(right: size.width * .03),
  //           width: size.width * .7,
  //           child: Form(
  //             key: _formKey,
  //             child: TextFormField(
  //               style:
  //                   TextStyle(fontSize: size.width * .054, color: Colors.white),
  //               controller: _nameControler,
  //               validator: (value) {
  //                 return null;
  //               },
  //             ),
  //           ),
  //         ),
  //         Container(
  //             margin: EdgeInsets.only(
  //                 right: size.width * .01, top: size.width * .01),
  //             child: IconButton(
  //                 onPressed: () async {
  //                   await onSaved(context);
  //                 },
  //                 icon: Icon(Icons.save))),
  //       ]);
  // }



// (tabWidgets.isNotEmpty)
//                   ? ReorderableListView(
//                       children: tabWidgets[indexTab].wrkts!.map((e) {
//                         return GestureDetector(
//                           key: Key(e.name),
//                           onTap: () {
//                             showModalBottomSheet(
//                                 isScrollControlled: true,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(10),
//                                         topRight: Radius.circular(10))),
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return bottomPopUp(
//                                     size: size,
//                                     dataSecond: e,
//                                   );
//                                 });
//                           },
//                           child: PlansCards(
//                             titleFontSize: size.width * .04,
//                             title: e.name,
//                             size: size,
//                             icon: IconButton(
//                               icon: Icon(Icons.delete),
//                               onPressed: () async {
//                                 tabWidgets[indexTab].wrkts!.remove(e);
//                                 setState(() {});
//                               },
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                       onReorder: (int oldIndex, int newIndex) {
//                         setState(() {
//                           if (oldIndex < newIndex) {
//                             newIndex -= 1;
//                           }
//                           final item =
//                               tabWidgets[indexTab].wrkts!.removeAt(oldIndex);
//                           tabWidgets[indexTab].wrkts!.insert(newIndex, item);
//                         });
//                       },
//                     )
//                   : Center(
//                       child: Text('empty'),
//                     )