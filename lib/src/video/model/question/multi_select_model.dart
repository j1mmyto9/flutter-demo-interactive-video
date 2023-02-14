import 'dart:convert';

import 'package:demovideo/src/video/model/question/base_question_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MultiSelectModel extends BaseQuestionModel {
  final List<String> answers;
  final List<String> correctAnswer;
  List<String>? currentSelect;
  MultiSelectModel({
    required super.title,
    required super.type,
    this.currentSelect,
    this.correctAnswer = const [],
    this.answers = const [
      "Answer 1",
      "Answer 2",
      "Answer 3",
    ],
  });

  MultiSelectModel copyWith({
    String? title,
    int? type,
    List<String>? answers,
    List<String>? correctAnswer,
    List<String>? currentSelect,
  }) {
    return MultiSelectModel(
      title: title ?? this.title,
      type: type ?? this.type,
      answers: answers ?? this.answers,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      currentSelect: currentSelect ?? this.currentSelect,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'type': type,
      'answers': answers,
      'correctAnswer': correctAnswer,
      'currentSelect': currentSelect,
    };
  }

  factory MultiSelectModel.fromMap(Map<String, dynamic> map) {
    return MultiSelectModel(
      title: map['title'] as String,
      type: map['type'] as int,
      answers: List<String>.from((map['answers'] as List<String>)),
      correctAnswer: List<String>.from((map['correctAnswer'] as List<String>)),
      currentSelect: map['currentSelect'] != null
          ? List<String>.from((map['currentSelect'] as List<String>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MultiSelectModel.fromJson(String source) =>
      MultiSelectModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
