import 'package:builderworkoutplanner/models/exercise_model.dart';
import 'package:builderworkoutplanner/models/youtube_controller.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class bottomPopUp extends StatelessWidget {
  const bottomPopUp({
    Key? key,
    this.currentExercise,
    this.size,
    this.data,
    this.dataSecond,
  }) : super(key: key);

  final int? currentExercise;
  final Size? size;
  final List<Company>? data;
  final Company? dataSecond;

  @override
  Widget build(BuildContext context) {
    String? ytId = YoutubePlayer.convertUrlToId(
        '${(data == null) ? dataSecond!.imgurl : data![currentExercise!].imgurl}');

    return Container(
        height: size!.height * .5,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size!.height * .02,
              ),
              Center(
                child: Container(
                  height: size!.height * .3,
                  width: size!.width * .8,
                  child: YoutubePlayer(
                      controller: YoutubeController(address: '$ytId').ytController()),
                ),
              ),
              SizedBox(
                height: size!.height * .05,
              ),
              Center(
                child: Text(
                    (data == null)
                        ? dataSecond!.name
                        : data![currentExercise!].name,
                    style: TextStyle(
                        fontSize: size!.height * .025,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 15,
              ),
              // Container(
              //   padding: EdgeInsets.only(
              //       left: size!.width * .1, right: size!.width * .1),
              //   child: Text((data== null) ?dataSecond!.usage:data![currentExercise!].usage,
              //       style: TextStyle(
              //         fontSize: size!.height * .025,
              //       )),
              // ),
              SizedBox(
                height: 15,
              ),
              // Container(
              //   padding: EdgeInsets.only(
              //       left: size!.width * .1, right: size!.width * .1),
              //   child: Text((data== null) ?dataSecond!.howto:'${data![currentExercise!].howto}',
              //       style: TextStyle(
              //         fontSize: size!.height * .025,
              //       )),
              // ),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ));
  }
}
