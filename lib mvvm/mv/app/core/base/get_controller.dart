import 'package:builderworkoutplanner/models/db_helper.dart';
import 'package:builderworkoutplanner/models/exercise_model.dart';
import 'package:builderworkoutplanner/models/prefs.dart';
import 'package:get/get.dart';

class ExerciseController extends GetxController {
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  var allExercises = <Company>[].obs;
  var temp = <Company>[].obs;
  var selectedExercises = <Company>[].obs;

  @override
  void onClose() {
    allExercises.close();
    selectedExercises.close();
    temp.close();
    super.onClose();
  }

  savePlan({required plan, required planName}) async {
    await Prefs().saveData(plan: plan, name: planName);
  }

  void duplicate() {
    var checked =
        selectedExercises.where((p0) => p0.isSelected == true).toList();
    selectedExercises.addAll(RxList.generate(checked.length, (index) {
      return Company(
        name: checked[index].name,
        id: index + selectedExercises.length,
        howTo: checked[index].howTo,
        imgurl: checked[index].imgurl,
        isSelected: false,
        sets: null,
        usage: checked[index].usage,
      );
    }));
    selectedExercises.forEach((element) {
      element.isSelected = false;
    });
    selectedExercises.refresh();
  }

  void deletedExercises() {
    print('deletedExercises called');
    selectedExercises.removeWhere((element) => element.isSelected == true);
    selectedExercises.forEach((element) {
      element.isSelected = false;
    });
    selectedExercises.refresh();
  }

  void checkBoxes(index, val) {
    print('checkBoxes called');
    selectedExercises[index].isSelected = val;
    selectedExercises.refresh();
  }

  void addSet(int id, set) {
    print('addSet called');
    if (selectedExercises[id].sets != null) {
      selectedExercises[id].sets!.add(set);
    } else {
      selectedExercises[id].sets = [set];
    }
    selectedExercises.refresh();
  }

  void removeSet(id) {
    print('Remove Set called');
    if (selectedExercises[id].sets != null &&
        selectedExercises[id].sets!.isNotEmpty) {
      selectedExercises[id].sets?.removeLast();
      selectedExercises.refresh();
    }
  }

  void getExercises() async {
    print('Starting qeury');
    List<Map<String, dynamic>> tasks = await DbHelper.getExercise();
    allExercises.assignAll(tasks.map((e) => Company.fromJson(e)).toList());
    temp.assignAll(allExercises);
  }

  void searchExercises(search) async {
    print('searchExercises called');
    allExercises.assignAll(temp
        .where((e) => e.name!.toLowerCase().contains(search.toLowerCase())));

    allExercises.refresh();
    temp.refresh();
  }

  void selectExercises(index, isCheck) {
    print('selectExercises called');
    allExercises[index].ischeck = isCheck;
    temp.refresh();
    allExercises.refresh();
  }

  void generateSelectedExercises() {
    print('generateSelectedExercises called');
    selectedExercises
        .addAll(allExercises.where((e) => e.ischeck == true).toList());
  }

  void dispose() {
    temp.clear();
    allExercises.clear();
    selectedExercises.clear();
  }
}
