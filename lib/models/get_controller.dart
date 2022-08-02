import 'package:builderworkoutplanner/models/db_helper.dart';
import 'package:builderworkoutplanner/models/exercise_model.dart';
import 'package:get/get.dart';

class ExerciseController extends GetxController {
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  var allExercises = <Company>[].obs;
  var selectedExercises = <Company>[].obs;
  void planDetailes(int id, set) async {
    if (selectedExercises[id].sets != null) {
      selectedExercises[id].sets!.add(set);
    } else {
      selectedExercises[id].sets = [set];
    }
    selectedExercises.refresh();
  }

  void getExercises() async {
    print('Starting qeury');
    List<Map<String, dynamic>> tasks = await DbHelper.getExercise();
    allExercises.assignAll(tasks.map((e) => Company.fromJson(e)).toList());
    selectedExercises.clear();
  }

  void searchExercises(search) async {
    print('Start  Searching');
    List<Map<String, dynamic>> tasks = await DbHelper.getExercise();
    var converted = tasks.map((e) => Company.fromJson(e)).toList();

    selectedExercises.forEach((x) {
      if (x.ischeck == true) {
        converted.forEach((y) {
          if (y.name == x.name) {
            y.ischeck = true;
          }
        });
      }
    });
    allExercises.assignAll(converted
        .where((e) => e.name.toLowerCase().contains(search.toLowerCase()))
        .toList());

    allExercises.refresh();
  }

  void selectExercises(id, isCheck) {
    allExercises[id].ischeck = isCheck;
    if (isCheck) {
      selectedExercises.add(allExercises[id]);
    } else {
      selectedExercises.remove(allExercises[id]);
    }
    allExercises.refresh();
  }
}
