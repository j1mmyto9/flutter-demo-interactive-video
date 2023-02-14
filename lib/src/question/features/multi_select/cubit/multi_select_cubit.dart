import 'package:bloc/bloc.dart';
import 'package:demovideo/src/video/model/question/multi_select_model.dart';
import 'package:equatable/equatable.dart';

part 'multi_select_state.dart';

class MultiSelectCubit extends Cubit<MultiSelectState> {
  MultiSelectCubit(MultiSelectModel model)
      : super(MultiSelectState(model: model)) {
    initQuestion();
  }

  void selectChoice(String value) {
    List<String> currentSelect = List.from(state.currentSelects);
    if (currentSelect.contains(value)) {
      currentSelect.remove(value);
    } else {
      currentSelect.add(value);
    }
    emit(state.copyWith(currentSelects: currentSelect));
  }

  void checkAnswer() {
    List<String> currentCorrect = [];
    for (String selectAnswer in state.currentSelects) {
      if (state.model.correctAnswer.contains(selectAnswer)) {
        currentCorrect.add(selectAnswer);
      }
    }
    if (currentCorrect.length == state.model.correctAnswer.length &&
        state.currentSelects.length == state.model.correctAnswer.length) {
      emit(state.copyWith(
          isCorrect: true, hasChecked: true, currentCorrect: currentCorrect));
    } else {
      emit(state.copyWith(
          isCorrect: false, hasChecked: true, currentCorrect: currentCorrect));
    }
  }

  void initQuestion() {
    if (state.model.currentSelect != null) {
      emit(state.copyWith(currentSelects: state.model.currentSelect));
      checkAnswer();
    } else {
      emit(state.copyWith(
        hasChecked: false,
        currentSelects: [],
        isCorrect: false,
      ));
    }
  }
}
