import 'dart:convert';

import 'package:builderworkoutplanner/data.dart';
import 'package:builderworkoutplanner/models/exercise_model.dart';
import 'package:builderworkoutplanner/models/json_plans_model.dart';
import 'package:builderworkoutplanner/models/tab_models.dart';
import 'package:builderworkoutplanner/pages/app_plans_page.dart';
import 'package:builderworkoutplanner/pages/home_page.dart';
import 'package:builderworkoutplanner/widgets/bottom_popup.dart';
import 'package:builderworkoutplanner/widgets/listview_card.dart';
import 'package:builderworkoutplanner/widgets/rounded_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
          appBar: AppBar(
              backgroundColor: Colors.blue[400],
              bottom: TabBar(
                  indicatorColor: Colors.white,
                  isScrollable: true,
                  tabs: tabNames
                      .map(
                        (e) => Tab(
                          child: Row(children: [
                            Text(
                              'Day $e',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.height * .025),
                            ),
                            (tabNames.length > 1)
                                ? Container(
                                    width: size.width * .05,
                                    child: IconButton(
                                        onPressed: () {
                                          tabNames.remove(e);
                                          tabWidgets.removeAt(e - 1);

                                          tabNames = List.generate(
                                              tabNames.length,
                                              (index) => index + 1);

                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: size.width * .05,
                                        )),
                                  )
                                : Center(),
                          ]),
                        ),
                      )
                      .toList()),
              actions: [
                Container(
                  margin: EdgeInsets.only(right: size.width * .03),
                  width: size.width * .7,
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: size.width * .054, color: Colors.white),
                      controller: _nameControler,
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                        right: size.width * .01, top: size.width * .01),
                    child: IconButton(
                        onPressed: () async {
                          await onSaved(context);
                        },
                        icon: Icon(Icons.save))),
              ]),
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

  Stack widgets(BuildContext context, Size size, int indexTab) {
    return Stack(children: [
      Column(
        children: [
          SizedBox(
            height: size.height * .03,
          ),
          Expanded(
              child: (tabWidgets.isNotEmpty)
                  ? ReorderableListView(
                      children: tabWidgets[indexTab].wrkts!.map((e) {
                        return GestureDetector(
                          key: Key(e.name),
                          onTap: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                context: context,
                                builder: (BuildContext context) {
                                  return bottomPopUp(
                                    size: size,
                                    dataSecond: e,
                                  );
                                });
                          },
                          child: PlansCards(
                            titleFontSize: size.width * .04,
                            title: e.name,
                            size: size,
                            icon: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                tabWidgets[indexTab].wrkts!.remove(e);
                                setState(() {});
                              },
                            ),
                          ),
                        );
                      }).toList(),
                      onReorder: (int oldIndex, int newIndex) {
                        setState(() {
                          if (oldIndex < newIndex) {
                            newIndex -= 1;
                          }
                          final item =
                              tabWidgets[indexTab].wrkts!.removeAt(oldIndex);
                          tabWidgets[indexTab].wrkts!.insert(newIndex, item);
                        });
                      },
                    )
                  : Center(
                      child: Text('empty'),
                    ))
        ],
      ),
      Positioned(
        bottom: 10,
        left: size.width * .1,
        right: size.width * .52,
        child: ElevatedButton(
          onPressed: () async {
            var result = await Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return AddExercise(tableData: tabWidgets[indexTab].wrkts);
            })) as List<Company>?;
            if (result != null) {
              tabWidgets[indexTab].wrkts = result;
            }

            setState(() {});
          },
          child: Text(
            "Add an Exercise",
            style: TextStyle(
                fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(secondColor))),
        ),
      ),
      Positioned(
        bottom: 10,
        left: size.width * .52,
        right: size.width * .1,
        child: ElevatedButton(
          onPressed: () async {
            tabNames.add(tabNames.length + 1);
            tabWidgets.add(Tabs(name: '', wrkts: []));
            setState(() {});
          },
          child: Text(
            "Add a Day",
            style: TextStyle(
               fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(secondColor))),
        ),
      ),
    ]);
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
