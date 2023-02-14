part of 'fill_blank_cubit.dart';

class FillBlankState extends Equatable {
  const FillBlankState(
      {required this.model,
      this.currentAnswer = const [],
      this.currentCorrect = const [],
      this.hasChecked = false,
      this.isCorrect = false});
  final FillBlankModel model;
  final List<String> currentAnswer;
  final List<String> currentCorrect;
  final bool hasChecked;
  final bool isCorrect;
  @override
  List<Object> get props =>
      [model, currentAnswer, hasChecked, isCorrect, currentCorrect];

  FillBlankState copyWith(
      {FillBlankModel? model,
      List<String>? currentAnswer,
      List<String>? currentCorrect,
      bool? hasChecked,
      bool? isCorrect}) {
    return FillBlankState(
        model: model ?? this.model,
        currentAnswer: currentAnswer ?? this.currentAnswer,
        currentCorrect: currentCorrect ?? this.currentCorrect,
        hasChecked: hasChecked ?? this.hasChecked,
        isCorrect: isCorrect ?? this.isCorrect);
  }
}
