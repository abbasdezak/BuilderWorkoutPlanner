import 'package:builderworkoutplanner/models/exercise_model.dart';
import 'package:builderworkoutplanner/models/youtube_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
                  child: CachedNetworkImage(
                    imageUrl: '${data![currentExercise!].imgurl}',
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
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
              Container(
                margin: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        (data == null)
                            ? dataSecond!.howTo!
                            : data![currentExercise!].howTo!,
                        style: TextStyle(
                            fontSize: size!.height * .025,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                        (data == null)
                            ? dataSecond!.usage!
                            : data![currentExercise!].usage!,
                        style: TextStyle(
                            fontSize: size!.height * .025,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
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
