import 'package:bassant_academy/app/util/util.dart';
import 'package:bassant_academy/data/entities/lecture_model.dart';
import 'package:bassant_academy/presentation/controller/home_screen/home_screen_controller.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final LectureModel lectureModel;

  const VideoPlayerScreen({
    super.key,
    required this.lectureModel,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool secureMode = true;

  YoutubePlayerController? _controller;

  bool showLectureName = true;

  @override
  void initState() {
    super.initState();

    String? videoId = _getYoutubeVideoIdByURL(widget.lectureModel.url);
    if (videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          showLiveFullscreenButton: true,
        ),
      );
      // _controller!.addListener(listener);
      _controller!.toggleFullScreenMode();
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller?.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller!.toggleFullScreenMode();
    _controller?.dispose();
    super.dispose();
  }

  //
  // void listener() {
  //   if (_isPlayerReady && mounted && !_controller!.value.isFullScreen) {
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: BackButton(
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: _controller == null
          ? const SizedBox()
          : Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                YoutubePlayer(
                  controller: _controller!,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Theme.of(context).primaryColor,
                  progressColors: ProgressBarColors(
                    playedColor: Theme.of(context).primaryColor,
                    handleColor: Theme.of(context).primaryColor.withOpacity(0.5),
                  ),
                  onEnded: (youtubeMetaDate) {
                    Get.back();
                  },
                  onReady: () {},
                  bottomActions: const [
                    // FullScreenButton(
                    // ),
                    CurrentPosition(),
                    ProgressBar(
                      isExpanded: true,
                    ),
                    RemainingDuration(),
                  ],
                ),
                PositionedDirectional(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Offstage(
                          offstage: !showLectureName,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showLectureName = !showLectureName;
                              });
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white24,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: AppText(
                                  widget.lectureModel.name ?? '',
                                  color: Colors.white60,
                                  fontSize: 24,
                                  maxLines: 3,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white24,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showLectureName = !showLectureName;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(
                                showLectureName ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: RotationTransition(
                    turns: const AlwaysStoppedAnimation(15 / 360),
                    child: AppText(
                      Get.find<HomeScreenController>().profileResponse?.data?.user?.phone ?? '',
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white30,
                    ),
                  ),
                )
              ],
            ),
    );
  }

  String? _getYoutubeVideoIdByURL(String? url) {
    if (url == null) {
      return null;
    } else {
      String? videoId;
      // videoId = YoutubePlayer.convertUrlToId(
      //     "https://www.youtube.com/watch?v=BBAyRBTfsOU");
      videoId = YoutubePlayer.convertUrlToId(url);

      Utils.logMessage('Youtube Video Id$videoId');
      return videoId;
    }
  }
}
