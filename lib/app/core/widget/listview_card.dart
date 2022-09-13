import 'package:flutter/material.dart';

class PlansCards extends StatefulWidget {
  const PlansCards(
      {Key? key,
      this.image,
      this.title,
      this.subTitle,
      this.time,
      this.titleFontSize,
      this.icon,
      this.onTap})
      : super(key: key);
  final String? title;
  final TextStyle? titleFontSize;
  final String? subTitle;
  final String? time;
  final Widget? image;
  final VoidCallback? onTap;

  final Widget? icon;

  @override
  _PlansCardsState createState() => _PlansCardsState();
}

class _PlansCardsState extends State<PlansCards> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        height: size!.height * .13,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.3),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 4)),
            ]),
        child: Row(
          children: [
            (widget.image != null)
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: 50,
                    height: 50,
                    child: widget.image!)
                : Center(),
            SizedBox(
              width: size!.width * .05,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size!.width * .45,
                    child: Text((widget.title) != null ? "${widget.title}" : '',
                        style: widget.titleFontSize),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  (widget.subTitle) != null
                      ? Text("${widget.subTitle} ",
                          style: TextStyle(fontSize: 14, color: Colors.grey))
                      : SizedBox(
                          height: 0,
                        ),
                ],
              ),
            ),
            widget.icon != null ? widget.icon! : Center(),
            SizedBox(
              width: size.width * .05,
            ),
          ],
        ),
      ),
    );
  }
}
