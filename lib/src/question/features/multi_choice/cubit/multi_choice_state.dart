// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'multi_choice_cubit.dart';

class MultiChoiceState extends Equatable {
  const MultiChoiceState(
      {required this.model,
      this.currentChoice = -1,
      this.hasChecked = false,
      this.isCorrect = false,
      this.showAnswer = false});
  final MultiChoiceModel model;
  final int currentChoice;
  final bool hasChecked;
  final bool isCorrect;
  final bool showAnswer;
  @override
  List<Object> get props =>
      [model, currentChoice, hasChecked, isCorrect, showAnswer];

  MultiChoiceState copyWith(
      {MultiChoiceModel? model,
      int? currentChoice,
      bool? hasChecked,
      bool? isCorrect,
      bool? showAnswer}) {
    return MultiChoiceState(
        model: model ?? this.model,
        currentChoice: currentChoice ?? this.currentChoice,
        hasChecked: hasChecked ?? this.hasChecked,
        isCorrect: isCorrect ?? this.isCorrect,
        showAnswer: showAnswer ?? this.showAnswer);
  }
}
