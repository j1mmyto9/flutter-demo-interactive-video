part of 'multi_select_cubit.dart';

class MultiSelectState extends Equatable {
  const MultiSelectState(
      {required this.model,
      this.currentSelects = const [],
      this.currentCorrect = const [],
      this.hasChecked = false,
      this.isCorrect = false});
  final MultiSelectModel model;
  final List<String> currentSelects;
  final List<String> currentCorrect;
  final bool hasChecked;
  final bool isCorrect;
  @override
  List<Object> get props =>
      [model, currentSelects, hasChecked, isCorrect, currentCorrect];

  MultiSelectState copyWith(
      {MultiSelectModel? model,
      List<String>? currentSelects,
      List<String>? currentCorrect,
      bool? hasChecked,
      bool? isCorrect}) {
    return MultiSelectState(
        model: model ?? this.model,
        currentSelects: currentSelects ?? this.currentSelects,
        currentCorrect: currentCorrect ?? this.currentCorrect,
        hasChecked: hasChecked ?? this.hasChecked,
        isCorrect: isCorrect ?? this.isCorrect);
  }
}
