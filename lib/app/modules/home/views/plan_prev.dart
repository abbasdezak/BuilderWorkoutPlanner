import 'package:builderworkoutplanner/app/core/values/app_colors.dart';
import 'package:builderworkoutplanner/app/core/values/theme.dart';
import 'package:builderworkoutplanner/app/core/widget/app_bar.dart';
import 'package:builderworkoutplanner/app/core/widget/listview_card.dart';
import 'package:builderworkoutplanner/app/modules/home/model/grid_card.dart';
import 'package:builderworkoutplanner/app/modules/home/widget/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PlanPreview extends StatelessWidget {
  PlanPreview({Key? key}) : super(key: key);
  var cardIcons = [
    Icons.check_circle_outline_rounded,
    Icons.fitness_center_outlined,
    Icons.animation_outlined,
    Icons.fitbit_outlined
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar().appBar(Container(
          alignment: Alignment.center,
          child: Text(
            'Edit',
            style: subTitleStyle,
          ))),
      body: SingleChildScrollView(
        child: Column(children: [
          WorkoutPrevChart(
            height: size.height * .45,
            width: size.width,
          ),
          _gridCard(size),
          Container(
            margin: EdgeInsets.only(left: 25),
            alignment: Alignment.centerLeft,
            child: Text(
              'Exercises',
              style: smallTitleStyleGrey,
            ),
          ),
          Container(
            height: 100,
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                
                  return PlansCards(
                    onTap: () async {
                      // await Navigator.push(context, MaterialPageRoute(
                      //     builder: (BuildContext context) {
                      //   return PlansList(
                      //       plans: _p.plans?[index] ?? Plans());
                      // }));
                    },
                    icon: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        // _homeController.deleteExercise(index);
                      },
                    ),
                    // image: Image.asset('assets/images/$imageIndex.jpg'),
                    title: '_p[index].planName',
                    subTitle: 'Splits',
                    titleFontSize: titleStyle,
                  );
                }),
          )
        ]),
      ),
    );
  }

  _gridCard(size) {
    return Container(
        width: size.width,
        height: size.height * .31,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: 4,
          padding: EdgeInsets.all(10),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[200]!, width: 1)),
              padding: EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    cardIcons[index],
                    color: AppColors.Blue7,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (((index + 1) * 3) % 7).toString(),
                        style: bigTitleStyle,
                      ),
                      Text(
                        'workouts\ncompleted',
                        style: smallTitleStyleGrey,
                      ),
                    ],
                  )
                ],
              )),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2,
          ),
        ));
  }
}
