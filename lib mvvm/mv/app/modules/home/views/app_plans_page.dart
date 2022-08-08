import 'dart:convert';
import 'package:builderworkoutplanner/pages/workout_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../models/json_plans_model.dart';
import '../widgets/plans_card.dart';

class AppPlans extends StatefulWidget {
  const AppPlans({Key? key}) : super(key: key);

  @override
  _AppPlansState createState() => _AppPlansState();
}

class _AppPlansState extends State<AppPlans> {
  Future loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/plans/myplans.json');
    Map<String, dynamic> data = json.decode(jsonText);
    
    return JsonPlansModel.fromJson(data);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: size.height * .08,
        ),
        Text(
          'Workout Plans',
          style: TextStyle(
              fontSize: size.height * .04, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: size.height * .06,
        ),
        widgets(size)
      ]),
    );
  }

  Widget widgets(size) {
    return FutureBuilder(
        future: loadJsonData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            JsonPlansModel jsonPlan = snapshot.data as JsonPlansModel;
            return Container(
              height: size.height * .8,
              child: ListView.builder(
                itemCount: jsonPlan.plans!.length,
                itemBuilder: ((context, index) {
                  var plans = jsonPlan.plans![index];
                  return Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: size.width * .04),
                        child: Text(
                          '${plans.name}',
                          style: TextStyle(
                              fontSize: size.height * .024,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                          height: size.height * .28,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: ListView.builder(
                            itemCount: plans.splits!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return PlansCard(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                WorkoutPage(
                                                  workoutNameLists: plans
                                                      .splits![index].exrcs,
                                                )));
                                  },
                                  cardName: ' ${plans.splits![index].name}');
                            },
                          )),
                    ],
                  );
                }),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
