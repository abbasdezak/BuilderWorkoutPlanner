
import 'package:builderworkoutplanner/app/core/values/app_colors.dart';
import 'package:builderworkoutplanner/app/core/widget/bottom_popup.dart';
import 'package:builderworkoutplanner/app/core/widget/linked_label_check_box.dart';
import 'package:builderworkoutplanner/app/core/widget/rounded_text_field.dart';
import 'package:builderworkoutplanner/app/modules/add_new_workout_plan/controllers/add_new_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../core/model/exercise_model.dart';
import 'add_sets.dart';
class AddExercise extends StatefulWidget {
  const AddExercise({Key? key, this.tableData}) : super(key: key);
  final List<Company>? tableData;
  @override
  _AddExerciseState createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  var is_loaded = false;
  final _exercoseController = Get.put(AddNewController());

  @override
  initState() {
    super.initState();
    _exercoseController.getExercises();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: AppColors.darkBlue,
        appBar: _appBar(context),
        body: Column(
          children: [
            _searchBar(size),
            _listView(size),
          ],
        ));
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
            onTap: () {
              _exercoseController.generateSelectedExercises();
              if (_exercoseController.selectedExercises.isNotEmpty) {
                Get.to(() => AddSets());
              } else {
                Get.snackbar('Required', 'At least one exercise required !',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.grey[100],
                    icon: Icon(
                      Icons.warning,
                      color: Colors.red,
                    ),
                    margin: EdgeInsets.all(20));
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
          Navigator.pop(context);
        },
      ),
    );
  }

  Container _searchBar(Size size) {
    return Container(
      height: size.height * .22,
      width: size.width,
      margin: EdgeInsets.only(top: size.height * .02, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Exercises',
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
          SizedBox(
            height: size.height * .03,
          ),
          RoundedInputField(
            leading: Icon(
              Icons.search,
              color: Colors.white,
            ),
            color: AppColors.darkBlue,
            widthSize: size.width * .95,
            heightSize: size.height * .06,
            hintText: 'Search',
            onChanged: (String text) {
              _exercoseController.searchExercises(text);
            },
          ),
        ],
      ),
    );
  }

  _listView(Size size) {
    return Obx(() {
      var exrcs = _exercoseController.allExercises;
      return Expanded(
        child: Container(
          color: Colors.white,
          child: ListView.builder(
              itemCount: exrcs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => showModalBottomSheet(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      context: context,
                      builder: (BuildContext context) {
                        return bottomPopUp(
                          currentExercise: index,
                          size: size,
                          data: exrcs,
                        );
                      }),
                  child: LinkedLabelCheckbox(
                    currentExercise: index,
                    data: exrcs,
                    size: size,
                    label: "${exrcs[index].name}",
                    value: exrcs[index].ischeck ?? false,
                    onChanged: (bool? value) {
                      _exercoseController.selectExercises(index, value);
                    },
                    secondary: GestureDetector(
                      child: CachedNetworkImage(
                        imageUrl: '${exrcs[index].imgurl}',
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                );
              }),
        ),
      );
    });
  }
// open the database
}
