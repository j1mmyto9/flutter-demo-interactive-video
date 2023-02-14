// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:demovideo/src/video/model/question/base_question_model.dart';

class MultiChoiceModel extends BaseQuestionModel {
  final List<String> answers;
  final int correctAnswer;
  int? indexCurrent;
  MultiChoiceModel({
    required super.title,
    required super.type,
    this.indexCurrent,
    this.correctAnswer = 0,
    this.answers = const [
      "Answer 1",
      "Answer 2",
      "Answer 3",
    ],
  });

  MultiChoiceModel copyWith({
    String? title,
    int? type,
    List<String>? answers,
    int? correctAnswer,
    int? indexCurrent,
  }) {
    return MultiChoiceModel(
      title: title ?? this.title,
      type: type ?? this.type,
      answers: answers ?? this.answers,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      indexCurrent: indexCurrent ?? this.indexCurrent,
    );
  }
}
