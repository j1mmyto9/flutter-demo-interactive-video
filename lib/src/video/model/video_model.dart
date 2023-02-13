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
      path: "assets/videos/demo_video.mp4",
      duration: 31,
      timelines: [
        VideoTimeLine(
          5,
          8,
          question: VideoQuestion("Q1: from 5 to 8"),
        ),
        VideoTimeLine(
          15,
          20,
          question: VideoQuestion("Q2: from 15 to 20"),
        ),
        VideoTimeLine(
          24,
          29,
          question: VideoQuestion("Q3: from 24 to 29"),
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
  int? index;
  VideoQuestion(
    this.title, {
    this.answers = const [
      "Answer 1",
      "Answer 2",
      "Answer 3",
    ],
  });
}
