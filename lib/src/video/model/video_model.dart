// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:demovideo/src/video/model/question/base_question_model.dart';
import 'package:demovideo/src/video/model/question/fill_blank_model.dart';
import 'package:demovideo/src/video/model/question/multi_choice_model.dart';
import 'package:demovideo/src/video/model/question/multi_select_model.dart';
import 'package:demovideo/src/video/model/question/question_type.dart';

class VideoModel {
  String title;
  String path;
  int duration;
  List<VideoTimeLine> timelines;
  VideoModel({
    required this.title,
    required this.path,
    required this.duration,
    required this.timelines,
  });
  static VideoModel example() {
    return VideoModel(
      title: "Video Demo",
      path: "assets/videos/iv.mp4",
      duration: 65,
      timelines: [
        VideoTimeLine(
          10,
          15,
          question: MultiChoiceModel(
            type: VideoQuestionType.multipleChoice,
            title: "Q1: What kind of berry is this?",
            answers: ["Blueberry", "Strawberry"],
            correctAnswer: 1,
          ),
        ),
        VideoTimeLine(
          20,
          25,
          question: MultiSelectModel(
            type: VideoQuestionType.multipleSelect,
            title: "Highlight the ingredients that have been added so far.",
            answers: ["Blueberry", "Strawberry", "Mango", "Apple"],
            correctAnswer: ["Blueberry", "Strawberry"],
          ),
        ),
        VideoTimeLine(
          30,
          35,
          question: FillBlankModel(
              type: VideoQuestionType.fillBlanks,
              title:
                  "Strawberries and *** berries are mixed with *** and oatmeal *** to make this delicious smoothie",
              correctAnswer: ["blue", "milk", "cookies"]),
        ),
      ],
    );
  }
}

class VideoTimeLine {
  int start;
  int end;
  BaseQuestionModel question;

  bool inRange(int sec) {
    return sec >= start && sec < end;
  }

  VideoTimeLine(
    this.start,
    this.end, {
    required this.question,
  });
}
