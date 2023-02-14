import 'package:demovideo/src/video/model/question/base_question_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FillBlankModel extends BaseQuestionModel {
  final List<String> correctAnswer;
  List<String>? currentAnswer;
  FillBlankModel({
    required super.title,
    required super.type,
    this.currentAnswer,
    this.correctAnswer = const [],
  });

  FillBlankModel copyWith({
    String? title,
    int? type,
    List<String>? correctAnswer,
    List<String>? currentAnswer,
  }) {
    return FillBlankModel(
      title: title ?? this.title,
      type: type ?? this.type,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      currentAnswer: currentAnswer ?? this.currentAnswer,
    );
  }
}
