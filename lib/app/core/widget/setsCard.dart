import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/exercise_model.dart';
import '../values/theme.dart';

class SetCard extends StatelessWidget {
  SetCard({
    Key? key,
    required this.index,
    this.isCheck,
    required this.selectedExercises,
    this.onCheckBoxChanged,
    this.onRemoveTap,
    this.onAddsetTap,
  }) : super(key: key);
  final int index;
  final bool? isCheck;
  final RxList<Company> selectedExercises;
  final Function(bool? val)? onCheckBoxChanged;
  final onRemoveTap;
  final onAddsetTap;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: size.width * .1,
            child: Checkbox(
              value: isCheck,
              onChanged: onCheckBoxChanged,
            )),
        Container(
          width: size.width * .9,
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[200]!, width: 1)),
          child: Column(
            children: [
              _heading(size),
              if (selectedExercises[index].sets != null)
                Column(
                    children: selectedExercises[index].sets!.map<Widget>((e) {
                  return _setTextFormFiels(
                      size: size,
                      index: e.setNumber,
                      repController: e.repsController,
                      weightController: e.weightController);
                }).toList())
              else
                Container(),
              _buttons(size),
            ],
          ),
        ),
      ],
    );
  }

  _heading(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Container(
            width: size.width * .2,
            child: CachedNetworkImage(
              imageUrl: '${selectedExercises[index].imgurl}',
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: size.width * .6,
            child: Text(
              selectedExercises[index].name!,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: size.height * .024,
              ),
            ),
          )
        ],
      ),
    );
  }

  _buttons(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: size.height * .08,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey[200]!, width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: onRemoveTap,
            child: Text(
              'Remove',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: size.height * .026,
                  fontWeight: FontWeight.w900),
            ),
          ),
          Container(
            width: 2,
            color: Colors.grey[200],
          ),
          GestureDetector(
            onTap: onAddsetTap,
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
    );
  }

  _setTextFormFiels({size, index, repController, weightController}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'SET $index',
            style: smalSubTitleStyle,
          ),
          Container(
            height: 60,
            width: 30,
            child: Column(
              children: [
                TextFormField(
                    controller: repController,
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    style: titleStyle,
                    onSaved: (value) => print(value),
                    decoration: InputDecoration.collapsed(
                        hintStyle: titleStyle, hintText: '')),
                Text(
                  'Reps',
                  style: smalSubTitleStyle,
                )
              ],
            ),
          ),
          Text(
            '*',
            style: subTitleStyle,
          ),
          Container(
            height: 60,
            width: 30,
            child: Column(
              children: [
                TextFormField(
                    controller: weightController,
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    style: titleStyle,
                    onSaved: (value) => print(value),
                    decoration: InputDecoration.collapsed(
                        hintStyle: titleStyle, hintText: '')),
                Text(
                  "Kg",
                  style: smalSubTitleStyle,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
