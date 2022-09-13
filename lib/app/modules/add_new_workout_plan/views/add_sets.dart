
import 'package:builderworkoutplanner/app/core/model/exercise_model.dart';
import 'package:builderworkoutplanner/app/core/values/app_colors.dart';
import 'package:builderworkoutplanner/app/core/values/theme.dart';
import 'package:builderworkoutplanner/app/core/widget/rounded_text_field.dart';
import 'package:builderworkoutplanner/app/core/widget/setsCard.dart';
import 'package:builderworkoutplanner/app/modules/add_new_workout_plan/controllers/add_new_controller.dart';
import 'package:builderworkoutplanner/app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSets extends StatefulWidget {
  final tableName;
  const AddSets({Key? key, this.tableName}) : super(key: key);

  @override
  _AddSetsState createState() => _AddSetsState();
}

class _AddSetsState extends State<AddSets> {
  TextEditingController _workoutName = new TextEditingController();
  AddNew _exerciseController = Get.put(AddNew());

  @override
  void initState() {
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
      child: Scaffold(
        backgroundColor: AppColors.darkBlue,
        appBar: _appBar(context),
        body: widgets(context, size),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.darkBlue,
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20),
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () async {
              if (!_exerciseController.selectedExercises
                  .every((e) => e.sets != null && e.sets!.isNotEmpty)) {
                Get.snackbar(
                    'Required', 'All exercises should have at least one set.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.grey[100],
                    icon: Icon(
                      Icons.warning,
                      color: Colors.red,
                    ),
                    margin: EdgeInsets.all(20));
              } else if (!_exerciseController.selectedExercises.every((e) =>
                  e.sets!.every((element) =>
                      element.repsController!.text.isNotEmpty &&
                      element.weightController!.text.isNotEmpty &&
                      element.repsController != null &&
                      element.weightController != null))) {
                Get.snackbar('Required',
                    'repsController and weightControllers amount should be set.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.grey[100],
                    icon: Icon(
                      Icons.warning,
                      color: Colors.red,
                    ),
                    margin: EdgeInsets.all(20));
              } else if (_workoutName == null || _workoutName.text.isEmpty) {
                Get.snackbar('Required', 'Wrokout name cant be empty.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.grey[100],
                    icon: Icon(
                      Icons.warning,
                      color: Colors.red,
                    ),
                    margin: EdgeInsets.all(20));
              } else {
                await _exerciseController.savePlan(
                    plan: _exerciseController.selectedExercises,
                    planName: _workoutName.text);
                Get.to(HomePage(
                  currIndex: 0,
                ));

                _exerciseController.dispose();
              }
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
          _exerciseController.getExercises();
          Get.back();
        },
      ),
    );
  }

  widgets(BuildContext context, Size size) {
    return Obx(() {
      bool showSettings = !_exerciseController.selectedExercises
          .every((element) => element.isSelected == false);
      print(showSettings);
      return Stack(children: [
        Column(
          children: [
            Container(
              height: size.height * .18,
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
                  RoundedInputField(
                    leading: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    color: AppColors.darkBlue,
                    widthSize: size.width * .95,
                    heightSize: size.height * .06,
                    hintText: 'Workout name eg: chest and back',
                    textControler: _workoutName,
                  ),
                ],
              ),
            ),
            Expanded(child: _listView(size))
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: AnimatedOpacity(
            opacity: showSettings ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInToLinear,
            child: Container(
              color: Colors.blue[800],
              width: showSettings ? size.width : 0,
              height: showSettings ? size.height * .08 : 0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _exerciseController.deletedExercises();
                      },
                      child: Container(
                        child: Text(
                          "Delete",
                          style: subTitleStyle,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        _exerciseController.duplicate();
                      },
                      child: Container(
                        child: Text(
                          "Duplicate",
                          style: subTitleStyle,
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ]);
    });
  }

  _listView(Size size) {
    return Obx(() {
      var exrcs = _exerciseController.selectedExercises;

      return Container(
        color: Colors.grey[100],
        child: ListView.builder(
            itemCount: exrcs.length,
            itemBuilder: (context, index) {
              return SetCard(
                onAddsetTap: () {
                  print('addSet ');
                  _exerciseController.addSet(
                      index,
                      SetDetails(
                          repsController: TextEditingController(),
                          weightController: TextEditingController(),
                          setNumber: (_exerciseController
                                      .selectedExercises[index].sets?.length ??
                                  0) +
                              1));
                },
                onRemoveTap: () => _exerciseController.removeSet(index),
                index: index,
                isCheck: exrcs[index].isSelected ?? false,
                onCheckBoxChanged: (val) {
                  _exerciseController.checkBoxes(index, val);
                },
                selectedExercises: exrcs,
              );
            }),
      );
    });
  }
}
