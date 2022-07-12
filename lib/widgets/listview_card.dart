import 'package:flutter/material.dart';

class PlansCards extends StatefulWidget {
  const PlansCards(
      {Key? key,
      this.image,
      this.title,
      this.subTitle,
      this.time,
      this.titleFontSize,
      this.size,
      this.icon,
      this.onTap})
      : super(key: key);
  final title;
  final titleFontSize;
  final subTitle;
  final time;
  final Widget? image;
  final Size? size;
  final VoidCallback? onTap;

  final Widget? icon;

  @override
  _PlansCardsState createState() => _PlansCardsState();
}

class _PlansCardsState extends State<PlansCards> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 5),
        width: double.infinity,
        height: widget.size!.height*.14,
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
              width: widget.size!.width*.05,
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: widget.size!.width * .45,
                    child: Text((widget.title) != null ? "${widget.title}" : '',
                        style: TextStyle(
                            fontSize: widget.titleFontSize,
                            fontWeight: FontWeight.bold)),
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
              width: widget.size!.width * .05,
            ),
            ],
        ),
        
      ),
    );
  }
}
