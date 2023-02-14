// ignore_for_file: public_member_api_docs, sort_constructors_first
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
          question: VideoQuestion("Q1: What kind of berry is this?",
              answers: ["Blueberry", "Strawberry"]),
        ),
        VideoTimeLine(
          20,
          25,
          question: VideoQuestion("Q2: from 20 to 25"),
        ),
        VideoTimeLine(
          30,
          35,
          question: VideoQuestion("Q3: from 30 to 35"),
        ),
        VideoTimeLine(
          40,
          45,
          question: VideoQuestion("Q4: from 40 to 45"),
        ),
        VideoTimeLine(
          50,
          55,
          question: VideoQuestion("Q5: from 50 to 55"),
        ),
        VideoTimeLine(
          59,
          63,
          question: VideoQuestion("Q6: from 60 to 65"),
        ),
      ],
    );
  }
}

class VideoTimeLine {
  int start;
  int end;
  VideoQuestion question;

  bool inRange(int sec) {
    return sec >= start && sec < end;
  }

  VideoTimeLine(
    this.start,
    this.end, {
    required this.question,
  });
}

class VideoQuestion {
  String title;
  List<String> answers;
  int correctAnswer;
  int questionType;
  int? index;
  VideoQuestion(
    this.title, {
    this.questionType = VideoQuestionType.multipleChoice,
    this.correctAnswer = 0,
    this.answers = const [
      "Answer 1",
      "Answer 2",
      "Answer 3",
    ],
  });
}

class VideoQuestionType {
  static const int multipleChoice = 1;
  static const int multipleSelect = 2;
  static const int fillBlanks = 3;
  static const int dragAndDrop = 4;
}
