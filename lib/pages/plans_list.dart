import 'package:builderworkoutplanner/pages/workout_page.dart';
import 'package:flutter/material.dart';

import '../models/json_plans_model.dart';
import '../models/prefs.dart';
import '../widgets/listview_card.dart';

class PlansList extends StatelessWidget {
  PlansList({Key? key, required this.plans}) : super(key: key);
  final Plans plans;
  int imageIndex = 1;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: size.height * .08,
          ),
          Text(
            '${plans.name}',
            style: TextStyle(
                fontSize: size.height * .04, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: size.height * .06,
          ),
          _widgets(size)
        ]),
      ),
    );
  }

  Widget _widgets(size) {
    return Container(
        height: size.width * .8,
        child: ListView.builder(
            itemCount: plans.splits?.length ?? 0,
            itemBuilder: (context, index) {
              if (imageIndex > 11) {
                imageIndex = 1;
              } else {
                imageIndex++;
              }
              return PlansCards(
                onTap: () async {
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return WorkoutPage(
                        workoutNameLists: plans.splits![index].exrcs);
                  }));
                },
                image: Image.asset('assets/images/$imageIndex.jpg'),
                size: size,
                title: plans.splits![index].name,
                titleFontSize: size.height * 0.0265,
              );
            }));
  }
}
