import 'dart:io';
import 'package:flutter/material.dart';

class PlansCard extends StatelessWidget {
  PlansCard({Key? key, this.cardName,required this.onTap}) : super(key: key);
  final String? cardName;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 15, top: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(.4),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3)),
                  ]),
              child: Icon(
                Icons.abc,
                size: 80,
              ),
            ),
            SizedBox(
                width: 100,
                child: Text('$cardName',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.height * .02,
                    ))),
          ],
        ),
      ),
    );
  }
}
