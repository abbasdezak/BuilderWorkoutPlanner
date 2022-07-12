import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeController {
  final String? address;

  YoutubeController({this.address});


  YoutubePlayerController ytController() {
    String ytId = YoutubePlayer.convertUrlToId(
            this.address ?? 'https://www.youtube.com/watch?v=ZWcRmoLqhkc')
        .toString();
    return YoutubePlayerController(
      initialVideoId: ytId,
      flags: YoutubePlayerFlags(
          hideControls: false,
          controlsVisibleAtStart: true,
          loop: true,
          autoPlay: true,
          mute: true,
          enableCaption: true),
    );
  }
}
