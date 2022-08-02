import 'package:builderworkoutplanner/models/exercise_model.dart';
import 'package:builderworkoutplanner/models/get_controller.dart';
import 'package:builderworkoutplanner/settings/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSets extends StatelessWidget {
  AddSets({
    Key? key,
    required this.exerciseName,
    required this.exerciseImage,
    this.repTEC,
    this.sets = const [],
    this.onAddSet,
    this.onRemove,
  }) : super(key: key);
  final String exerciseName;
  final String exerciseImage;
  final TextEditingController? repTEC;
  final List<Sets> sets;
  final Function()? onAddSet;
  final Function()? onRemove;
  // ExerciseController _exerciseController = Get.put(ExerciseController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(left: 15, bottom: 10),
      width: size.width * .9,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[200]!, width: 1)),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: [
                Container(
                  width: size.width * .2,
                  child: CachedNetworkImage(
                    imageUrl: '${exerciseImage}',
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  exerciseName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.height * .024,
                  ),
                )
              ],
            ),
          ),
          Column(
              children: sets
                  .map<Widget>((e) => _setTextFormFiels(size, e.setNumber))
                  .toList()),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: size.height * .08,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200]!, width: 1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Remove',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size.height * .026,
                      fontWeight: FontWeight.w900),
                ),
                Container(
                  width: 2,
                  color: Colors.grey[200],
                ),
                GestureDetector(
                  onTap: onAddSet,
                  child: Text(
                    'Add Set',
                    style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: size.height * .026,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _setTextFormFiels(size, index) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'SET $index',
            style: smalSubTitleStyle,
          ),
          _textInput(repTEC, 'Reps'),
          Text(
            '*',
            style: subTitleStyle,
          ),
          _textInput(repTEC, 'Kg'),
        ],
      ),
    );
  }

  Container _textInput(controller, label) {
    return Container(
      height: 60,
      width: 30,
      child: Column(
        children: [
          TextFormField(
              maxLength: 3,
              keyboardType: TextInputType.number,
              autofocus: false,
              controller: controller,
              style: titleStyle,
              decoration: InputDecoration.collapsed(
                  hintStyle: titleStyle, hintText: '')),
          Text(
            label,
            style: smalSubTitleStyle,
          )
        ],
      ),
    );
  }
}

class MyInputField extends StatelessWidget {
  const MyInputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget})
      : super(key: key);
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: titleStyle,
            ),
            Container(
              padding: EdgeInsets.only(left: 12),
              height: 52,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(top: 6),
              child: Expanded(
                  child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: widget != null ? true : false,
                      autofocus: false,
                      controller: controller,
                      style: subTitleStyle,
                      decoration: InputDecoration(
                          hintText: hint,
                          hintStyle: subTitleStyle,
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 0))),
                    ),
                  ),
                  widget == null
                      ? Container()
                      : Container(
                          child: widget,
                        )
                ],
              )),
            )
          ],
        ));
  }
}
