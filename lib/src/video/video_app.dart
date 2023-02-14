// ignore_for_file: avoid_print

import 'dart:math';

import 'package:chewie/chewie.dart';
import 'package:demovideo/src/question/features/fill_blank/fill_blank_widget.dart';
import 'package:demovideo/src/question/features/multi_choice/multi_choice_widget.dart';
import 'package:demovideo/src/question/features/multi_select/multi_select_widget.dart';
import 'package:demovideo/src/routing/routing.dart';
import 'package:demovideo/src/video/model/question/fill_blank_model.dart';
import 'package:demovideo/src/video/model/question/multi_choice_model.dart';
import 'package:demovideo/src/video/model/question/multi_select_model.dart';
import 'package:demovideo/src/video/model/video_model.dart';
import 'package:demovideo/src/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'model/question/question_type.dart';

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  const VideoApp({Key? key}) : super(key: key);
  @override
  VideoAppState createState() => VideoAppState();
}

class VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  VideoModel model = VideoModel.example();

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(model.path);
    _controller.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: true,
          looping: false,
          autoInitialize: true,
          showOptions: false,
          showControls: true,
          allowedScreenSleep: false,
          allowFullScreen: false,
          allowMuting: false,
          aspectRatio: _controller.value.aspectRatio,
        );
      });
    });

    _controller.addListener(videoListener);
  }

  int lastSec = -1;
  double? left = 300;
  double? right;
  double? top = 48;
  double? bottom;
  var rng = Random();
  bool expandedQuestion = false;
  VideoTimeLine? currentQuestion;
  void videoListener() {
    final VideoPlayerValue value = _controller.value;
    final int sec = value.position.inSeconds;
    if (sec == value.duration.inSeconds && sec != 0) {
      Navigator.of(context).pushReplacementNamed(RouteNames.home);
      return;
    }
    if (sec != lastSec) {
      lastSec = sec;
      print("_controller.position: $lastSec");
      if (currentQuestion != null) {
        checkCurrentQuestion(sec, currentQuestion!);
      } else {
        checkNextQuestion(sec);
      }
    }
  }

  void checkCurrentQuestion(int sec, VideoTimeLine question) {
    if (question.inRange(sec) == false) {
      setState(() {
        currentQuestion = null;
        expandedQuestion = false;
      });
    }
  }

  void checkNextQuestion(int sec) {
    for (var e in model.timelines) {
      if (e.inRange(sec)) {
        setState(() {
          currentQuestion = e;
          expandedQuestion = false;
          left = rng.nextInt(300) + 100;
          top = rng.nextInt(100) + 40;
        });
        return;
      }
    }
  }

  void onToggleExpanded() {
    setState(() {
      expandedQuestion = !expandedQuestion;
      if (expandedQuestion) {
        _chewieController.pause();
      } else {
        _chewieController.play();
      }
    });
  }

  void onSelectAnswer(dynamic value) {
    setState(() {
      switch (currentQuestion?.question.type) {
        case VideoQuestionType.multipleSelect:
          (currentQuestion?.question as MultiSelectModel).currentSelect = value;
          break;
        case VideoQuestionType.fillBlanks:
          (currentQuestion?.question as FillBlankModel).currentAnswer = value;
          break;
        default:
          (currentQuestion?.question as MultiChoiceModel).indexCurrent = value;
          break;
      }

      onToggleExpanded();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (_controller.value.isInitialized)
            Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
            )
          else
            const XIndicator(),
          if (currentQuestion != null)
            Positioned(
                left: left,
                top: top,
                child: Container(child: _getWidgetByType(currentQuestion!)))
        ],
      ),
    );
  }

  Widget _getWidgetByType(VideoTimeLine currentQuestion) {
    switch (currentQuestion.question.type) {
      case VideoQuestionType.multipleSelect:
        return MultiSelectWidget(
          (currentQuestion.question as MultiSelectModel),
          expanded: expandedQuestion,
          onTap: onToggleExpanded,
          onTapAt: onSelectAnswer,
        );
      case VideoQuestionType.fillBlanks:
        return FillBlankWidget(
          (currentQuestion.question as FillBlankModel),
          expanded: expandedQuestion,
          onTap: onToggleExpanded,
          onTapAt: onSelectAnswer,
        );
      default:
        return MultiChoiceWidget(
          (currentQuestion.question as MultiChoiceModel),
          expanded: expandedQuestion,
          index: (currentQuestion.question as MultiChoiceModel).indexCurrent,
          onTap: onToggleExpanded,
          onTapAt: onSelectAnswer,
        );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }
}
