import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:builderworkoutplanner/models/time_helper.dart';
import 'package:builderworkoutplanner/pages/home_page.dart';
import 'package:builderworkoutplanner/widgets/rounded_text_field.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Map _settingData = {};
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: TimeHelper.dataGetter('Settings', 'Setting'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _settingData = snapshot.data as Map;
            print(_settingData);
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .1,
                  ),
                  Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(
                          fontSize: size.height * .04,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .05,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: size.width * .08),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Personal',
                            style: TextStyle(
                                fontSize: size.height * .035,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: size.width * .05,
                        ),
                        CardWidget(
                            requiredValid: false,
                            dataId: _settingData['Name'],
                            size: size,
                            name: '${_settingData['Name']}',
                            nameId: 'Name',
                            image: Image(
                              image: AssetImage("assets/icons/male.jpg"),
                              height: 40,
                              width: 40,
                            )),
                        SizedBox(
                          height: size.width * .05,
                        ),
                        CardWidget(
                            requiredValid: true,
                            dataId: _settingData['Weight'],
                            nameId: 'Weight',
                            size: size,
                            name: 'Weight: ${_settingData['Weight']} ',
                            image: Image(
                              image: AssetImage("assets/images/weight.jpg"),
                              height: 40,
                              width: 40,
                            )),
                        SizedBox(
                          height: size.width * .05,
                        ),
                        CardWidget(
                            requiredValid: true,
                            dataId: _settingData['Height'],
                            name: 'Height: ${_settingData['Height']}',
                            size: size,
                            nameId: 'Height',
                            image: Image(
                              image: AssetImage("assets/images/height.jpg"),
                              height: 40,
                              width: 40,
                            )),
                        SizedBox(
                          height: size.width * .05,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Workout',
                            style: TextStyle(
                                fontSize: size.height * .035,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: size.width * .05,
                        ),
                        CardWidget(
                            requiredValid: false,
                            dataId: _settingData['Sets'],
                            name: 'Sets: ${_settingData['Sets']}',
                            size: size,
                            nameId: 'Sets',
                            image: Image(
                              image:
                                  AssetImage("assets/icons/sets_workout.png"),
                              height: 40,
                              width: 40,
                            )),
                        SizedBox(
                          height: size.width * .05,
                        ),
                        CardWidget(
                            requiredValid: false,
                            dataId: _settingData['Reps'],
                            name: 'Reps: ${_settingData['Reps']}',
                            size: size,
                            nameId: 'Reps',
                            image: Image(
                              image:
                                  AssetImage("assets/icons/reps_workout.png"),
                              height: 40,
                              width: 40,
                            )),
                        SizedBox(
                          height: size.width * .05,
                        ),
                        CardWidget(
                            requiredValid: false,
                            dataId: _settingData['Rest'],
                            name: 'Rest: ${_settingData['Rest']}',
                            size: size,
                            nameId: 'Rest',
                            image: Image(
                              image:
                                  AssetImage("assets/icons/rest_workout.png"),
                              height: 40,
                              width: 40,
                            )),
                        SizedBox(
                          height: size.width * .05,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

// ignore: must_be_immutable
class CardWidget extends StatefulWidget {
  bool requiredValid;
  var dataId;
  final String nameId;
  final Widget? image;
  final String? name;
  final String? subtitle;
  CardWidget({
    Key? key,
    required this.requiredValid,
    this.dataId,
    required this.nameId,
    this.image,
    this.name,
    this.subtitle,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final _formControler = GlobalKey<FormState>();

  final _data = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Row(
            children: [
              Container(margin: EdgeInsets.all(10), child: widget.image),
              SizedBox(
                width: widget.size.width * .05,
              ),
              Container(
                child: Text(
                  '${widget.name}',
                  style: TextStyle(
                      fontSize: widget.size.height * .028,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Positioned(
            right: widget.size.width * .12,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: IconButton(
                    onPressed: () {
                      showDlg(context);
                    },
                    icon: Icon(
                     Icons.keyboard_arrow_right_sharp,
                    ))),
          )
        ],
      ),
    );
  }

  showDlg(BuildContext context) {
    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              actionsPadding: EdgeInsets.all(5),
                              actions: [
                                Center(
                                    child: Text(
                                  '${widget.nameId}',
                                  style: TextStyle(
                                      fontSize: widget.size.height * .025,
                                      fontWeight: FontWeight.bold),
                                )),
                                SizedBox(
                                  height: 5,
                                ),
                                Form(
                                  key: _formControler,
                                  child: RoundedInputField(
                                    widthSize: widget.size.width * .8,
                                    hintText: '${widget.dataId}',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Field cant be empty';
                                      } else if (widget.nameId == 'Name') {
                                        return null;
                                      } else if (widget.requiredValid &
                                          (int.parse(value) < 20 ||
                                              int.parse(value) > 300)) {
                                        return 'Please enter valid numbers';
                                      } else {
                                        return (!value.contains(
                                                RegExp(r'^[0-9]*$')))
                                            ? 'Only Numbers.'
                                            : null;
                                      }
                                    },
                                    textControler: _data,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel')),
                                    ElevatedButton(
                                        onPressed: () async {
                                          if (_formControler.currentState!
                                              .validate()) {
                                            switch (widget.nameId) {
                                              case 'Name':
                                                TimeHelper.settingsSaver(
                                                    name: _data.text);

                                                break;
                                              case 'Weight':
                                                TimeHelper.settingsSaver(
                                                    weight: int.parse(
                                                        _data.text));

                                                break;
                                              case 'Height':
                                                TimeHelper.settingsSaver(
                                                    height: int.parse(
                                                        _data.text));

                                                break;
                                              case 'Sets':
                                                TimeHelper.settingsSaver(
                                                    sets: int.parse(
                                                        _data.text));

                                                break;
                                              case 'Reps':
                                                TimeHelper.settingsSaver(
                                                    reps: int.parse(
                                                        _data.text));

                                                break;
                                              case 'Rest':
                                                TimeHelper.settingsSaver(
                                                    rest: int.parse(
                                                        _data.text));

                                                break;
                                            }
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        HomePage(
                                                          currIndex: 2,
                                                        )));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Successfuly added new exercise")));
                                          }
                                        },
                                        child: Text('Save'))
                                  ],
                                ),
                              ],
                            ));
  }
}
