import 'dart:io';
import 'package:builderworkoutplanner/models/tab_models.dart';
import 'package:builderworkoutplanner/widgets/bottom_popup.dart';
import 'package:builderworkoutplanner/widgets/linked_label_check_box.dart';
import 'package:builderworkoutplanner/widgets/rounded_text_field.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:builderworkoutplanner/models/exercise_model.dart';

class AddExercise extends StatefulWidget {
  const AddExercise({Key? key, this.tableData}) : super(key: key);
  final List<Company>? tableData;
  @override
  _AddExerciseState createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  var is_loaded = false;
  TextEditingController name = new TextEditingController();
  TextEditingController desc = new TextEditingController();
  TextEditingController usg = new TextEditingController();
  List<Company> x = [];
  List<Company> searchFilter = [];

  @override
  initState() {
    // if (widget.tableData != null) {
    //   for (var y in widget.tableData!) {}
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (!is_loaded) {
      initializeDatabase();
    }

    return Scaffold(
        floatingActionButton: floatingBtn(context, size),
        appBar: AppBar(
          title: Text('Add exercies'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            !(searchFilter.every((element) => element.ischeck == false))
                ? IconButton(
                    onPressed: () async {
                      List<Company> addedExercise = searchFilter
                          .where((element) => element.ischeck == 1)
                          .toList();
                      setState(() {
                        Navigator.pop(context, addedExercise);
                      });
                    },
                    icon: Icon(Icons.save))
                : Text(''),
            SizedBox(width: 15),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              RoundedInputField(
                widthSize: size.width * .8,
                hintText: 'Search',
                onChanged: (String text) {
                  setState(() {
                    searchFilter = x
                        .where((e) =>
                            e.name.toLowerCase().contains(text.toLowerCase()))
                        .toList();
                  });
                },
              ),
              Flexible(
                child: ListView.builder(
                    itemCount: searchFilter.length,
                    itemBuilder: (context, index) {
                      bool check = false;
                      if (searchFilter[index].ischeck == 1) check = true;
                      return LinkedLabelCheckbox(
                        currentExercise: index,
                        data: searchFilter,
                        size: size,
                        label: "${searchFilter[index].name}",
                        value: check,
                        onChanged: (bool? value) {
                          int valuecheck = 0;
                          if (value == true) valuecheck = 1;
                          searchFilter[index].ischeck = valuecheck;
                          setState(() {});
                        },
                        secondary: GestureDetector(
                          child: SizedBox(),
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
                                      currentExercise: index,
                                      size: size,
                                      data: searchFilter);
                                });
                          },
                        ),
                        padding: EdgeInsets.all(5),
                      );
                    }),
              ),
            ],
          ),
        ));
  }

  FloatingActionButton floatingBtn(BuildContext context, Size size) {
    return FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    actionsPadding: EdgeInsets.all(15),
                    actions: [
                      Center(
                          child: Text(
                        'Add Exercise',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                      SizedBox(
                        height: 15,
                      ),
                      RoundedInputField(
                        widthSize: size.width * .8,
                        hintText: 'Name',
                        textControler: name,
                      ),
                      RoundedInputField(
                        widthSize: size.width * .8,
                        hintText: 'Description',
                        textControler: desc,
                      ),
                      RoundedInputField(
                        widthSize: size.width * .8,
                        hintText: 'Imapct eg: for abs',
                        textControler: usg,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel')),
                          ElevatedButton(
                              onPressed: () async {
                                if (name.text.isNotEmpty &&
                                    usg.text.isNotEmpty &&
                                    desc.text.isNotEmpty) {
                                  var databasesPath = await getDatabasesPath();
                                  var path = join(databasesPath, "x.db");
                                  final db = await openDatabase(path);
                                  await db.insert(
                                      'company',
                                      AddNewCompany(
                                              id: x.length,
                                              name: name.text,
                                              imgurl: '')
                                          .toMap());

                                  initializeDatabase();
                                  name.clear();
                                  usg.clear();
                                  desc.clear();
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Successfuly added new exercise")));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Values can't be empty")));
                                }
                              },
                              child: Text('Ok'))
                        ],
                      ),
                    ],
                  ));
        },
        child: Icon(
          Icons.add,
        ));
  }

  void initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "x.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "db/x.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    final db = await openDatabase(path);

    final List<Map<String, dynamic>> maps = await db.query('COMPANY');

    setState(() {
      searchFilter = List.generate(maps.length, (index) {
        return Company(
          id: index,
          ischeck: 0,
          name: maps[index]['NAME'],
          imgurl: (maps[index]["IMGURL"] != null) ? maps[index]["IMGURL"] : '',
        );
      });
    });

    if (widget.tableData != null) {
      for (var item in widget.tableData!) {
        searchFilter[item.id ?? 0].ischeck = 1;
      }
    }
    searchFilter.sort((a, b) => b.ischeck!.compareTo(a.ischeck!));
    x = searchFilter;
    is_loaded = true;
  }
// open the database
}
