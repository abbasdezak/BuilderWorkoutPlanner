import 'dart:convert';

import 'package:builderworkoutplanner/models/exercise_model.dart';
import 'package:builderworkoutplanner/models/json_plans_model.dart';
import 'package:builderworkoutplanner/models/prefs.dart';
import 'package:builderworkoutplanner/models/time_helper.dart';
import 'package:builderworkoutplanner/pages/plans_list.dart';
import 'package:builderworkoutplanner/pages/workout_page.dart';
import 'package:builderworkoutplanner/widgets/listview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiver/time.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../data.dart';
import 'add_new_page.dart';

class MainPageWidget extends StatefulWidget {
  final dataRquiredForBuild;
  const MainPageWidget({Key? key, this.dataRquiredForBuild}) : super(key: key);

  @override
  _MainPageWidgetState createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget> {
  int imageIndex = 1;
  Map? data;

  @override
  void initState() {
    super.initState();
  }

  dataLoader() async {
    data = await TimeHelper.dataGetter('Settings', 'Setting');
    return await Prefs().getData();
    
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: dataLoader(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var _p = snapshot.data as JsonPlansModel;

            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topCenter,
              child: Column(children: [
                SizedBox(
                  height: size.height * .02,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.topLeft,

                  // ignore: prefer_const_literals_to_create_immutables
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        // ignore: prefer_const_constructors
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hey ${data?['Name']}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // ignore: prefer_const_constructors
                                Text(
                                  "Don't Miss The Fitness! ",
                                  // ignore: prefer_const_constructors
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: size.width * .09,
                            ),
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                  border:
                                      Border.all(color: Color(secondColor))),
                              child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Image(
                                    image: AssetImage(data?['Gender'] == 1
                                        ? "assets/icons/male.jpg"
                                        : "assets/icons/female.jpg"),
                                    height: 40,
                                    width: 40,
                                  )),
                            )
                          ],
                        )
                      ]),
                ),
                Container(
                  height: size.height * .08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        "Your Plans",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.grey[500],
                          textStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (c) {
                            return secondPage();
                          }));
                        },
                        child: const Text("Add New "),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: (_p.plans?.length == 0)
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset("assets/images/empty.jpg",
                                  fit: BoxFit.fill),
                              Positioned(
                                bottom: 10,
                                child: Text(
                                  "Nothing is here! \n Click Add New to add new plans :)",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              )
                            ],
                          )
                        : ListView.builder(
                            itemCount: _p.plans?.length ?? 0,
                            itemBuilder: (context, index) {
                              if (imageIndex > 11) {
                                imageIndex = 1;
                              } else {
                                imageIndex++;
                              }
                              return PlansCards(
                                onTap: () async {
                                  await Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                    return PlansList(
                                        plans: _p.plans?[index] ?? Plans());
                                  }));
                                },
                                icon: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () async {
                                    Prefs().deleteData(index: index);
                                    setState(() {});
                                  },
                                ),
                                image: Image.asset(
                                    'assets/images/$imageIndex.jpg'),
                                size: size,
                                title: _p.plans?[index].name,
                                subTitle: '${_p.plans?.length} Splits',
                                titleFontSize: size.height * 0.0265,
                              );
                            }))
              ]),
            );
          } else {
            return Center(
              child: LinearProgressIndicator(),
            );
          }
        });
  }
}
