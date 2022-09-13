import 'package:builderworkoutplanner/app/core/model/time_helper.dart';
import 'package:builderworkoutplanner/app/core/widget/rounded_text_field.dart';
import 'package:builderworkoutplanner/app/my_app.dart';
import 'package:flutter/material.dart';

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
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: IconButton(
                    onPressed: () {
                      showDlg(context);
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_right_sharp,
                      color: Colors.white,
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
                          (int.parse(value) < 20 || int.parse(value) > 300)) {
                        return 'Please enter valid numbers';
                      } else {
                        return (!value.contains(RegExp(r'^[0-9]*$')))
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel')),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formControler.currentState!.validate()) {
                            switch (widget.nameId) {
                              case 'Name':
                                TimeHelper.settingsSaver(name: _data.text);

                                break;
                              case 'Weight':
                                TimeHelper.settingsSaver(
                                    weight: int.parse(_data.text));

                                break;
                              case 'Height':
                                TimeHelper.settingsSaver(
                                    height: int.parse(_data.text));

                                break;
                              case 'Sets':
                                TimeHelper.settingsSaver(
                                    sets: int.parse(_data.text));

                                break;
                              case 'Reps':
                                TimeHelper.settingsSaver(
                                    reps: int.parse(_data.text));

                                break;
                              case 'Rest':
                                TimeHelper.settingsSaver(
                                    rest: int.parse(_data.text));

                                break;
                            }
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => HomePage(
                                          currIndex: 2,
                                        )));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("Successfuly added new exercise")));
                          }
                        },
                        child: Text('Save'))
                  ],
                ),
              ],
            ));
  }
}
