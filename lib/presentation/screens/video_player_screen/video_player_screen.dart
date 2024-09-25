import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/data/entities/lecture_model.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../app/res/res.dart';
import '../../../app/util/constants.dart';
import '../../controller/home_screen/home_screen_controller.dart';

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
  bool showLectureName = true;

  late YoutubePlayerController _controller;

  bool isFullScreen = false;

  final homeScreenController = Get.find<HomeScreenController>();

  @override
  void initState() {
    // String url = 'https://www.youtube.com/watch?v=4h0G2LIvSHY';
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.lectureModel.url!)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        loop: false,
        mute: false,
      ),
    )..addListener(() {
        isFullScreen = _controller.value.isFullScreen;
        setState(() {});
      });
    super.initState();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool pop) async {
        _handleBackButton();
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Theme.of(context).primaryColor,
                    liveUIColor: Colors.transparent,
                    progressColors: ProgressBarColors(
                      playedColor: Theme.of(context).primaryColor,
                      handleColor:
                          Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                    thumbnail: Center(
                      child: SvgPicture.asset(
                        Res.iconLogo,
                        fit: BoxFit.contain,
                        width: isFullScreen ? 250 : 150,
                        height: isFullScreen ? 250 : 150,
                        // colorFilter: const ColorFilter.mode(
                        //   Colors.white,
                        //   BlendMode.srcIn,
                        // ),
                      ),
                    ),
                    onEnded: (youtubeMetaDate) {
                      _handleBackButton();
                    },
                    onReady: () {
                      setState(() {});
                    },
                    topActions: [
                      BackButton(
                        onPressed: _handleBackButton,
                        color: Theme.of(context).primaryColor,
                      )
                    ],
                    bottomActions: [
                      CurrentPosition(
                        controller: _controller,
                      ),
                      ProgressBar(
                        isExpanded: true,
                        controller: _controller,
                      ),
                      FullScreenButton(
                        controller: _controller,
                      ),
                    ],
                  ),
                  _studentPhone(),
                ],
              ),
            ),
            Expanded(
              flex: isFullScreen ? 0 : 3,
              child: Offstage(
                offstage: isFullScreen,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: AppText(
                          widget.lectureModel.name ?? '',
                          maxLines: 3,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Constants.kClickableTextColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                Res.iconClock,
                                width: 20,
                                height: 20,
                              ),
                              5.pw,
                              AppText(widget.lectureModel.duration ?? ''),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _studentPhone() {
    String? studentPhone;
    try {
      studentPhone =
          homeScreenController.profileResponse?.data?.user?.phone ?? '';
    } catch (e) {
      if (kDebugMode) {
        print('Error getting phone information');
      }
    }
    return Offstage(
      offstage: !isFullScreen,
      child: IgnorePointer(
        child: RotationTransition(
          turns: const AlwaysStoppedAnimation(15 / 360),
          child: Text(
            studentPhone ?? '',
            style: const TextStyle(
              fontSize: 46,
              fontWeight: FontWeight.bold,
              color: Colors.white30,
              letterSpacing: 14,
            ),
          ),
        ),
      ),
    );
  }

  void _handleBackButton() {
    if (isFullScreen) {
      _controller.toggleFullScreenMode();
    } else {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Get.back();
      });
    }
  }
}
