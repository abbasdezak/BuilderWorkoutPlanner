import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'bottom_popup.dart';

class LinkedLabelCheckbox extends StatelessWidget {
  const LinkedLabelCheckbox({
    Key? key,
    required this.label,
    required this.padding,
    required this.value,
    required this.onChanged,
    required this.secondary,
    required this.currentExercise,
    required this.size,
    this.data,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget secondary;
  final currentExercise;
  final Size size;
  final data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: size.height * .15,
      child: Row(
        children: <Widget>[
          secondary,
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: label,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          Checkbox(
            value: value,
            onChanged: (bool? newValue) {
              onChanged(newValue!);
            },
          ),
        ],
      ),
    );
  }
}
