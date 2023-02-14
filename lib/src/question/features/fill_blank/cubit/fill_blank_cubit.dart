import 'package:bloc/bloc.dart';
import 'package:demovideo/src/video/model/question/fill_blank_model.dart';
import 'package:equatable/equatable.dart';

part 'fill_blank_state.dart';

class FillBlankCubit extends Cubit<FillBlankState> {
  FillBlankCubit(FillBlankModel model) : super(FillBlankState(model: model)) {
    initQuestion();
  }

  void onChangeField(String value, int index) {
    List<String> currentAnswer = List.from(state.currentAnswer);
    currentAnswer[index] = value;
    emit(state.copyWith(currentAnswer: currentAnswer));
  }

  void selectChoice(String value) {
    List<String> currentSelect = List.from(state.currentAnswer);
    if (currentSelect.contains(value)) {
      currentSelect.remove(value);
    } else {
      currentSelect.add(value);
    }
    emit(state.copyWith(currentAnswer: currentSelect));
  }

  void checkAnswer() {
    List<String> currentCorrect = [];
    for (String selectAnswer in state.currentAnswer) {
      if (state.model.correctAnswer.contains(selectAnswer)) {
        currentCorrect.add(selectAnswer);
      }
    }
    if (currentCorrect.length == state.model.correctAnswer.length &&
        state.currentAnswer.length == state.model.correctAnswer.length) {
      emit(state.copyWith(
          isCorrect: true, hasChecked: true, currentCorrect: currentCorrect));
    } else {
      emit(state.copyWith(
          isCorrect: false, hasChecked: true, currentCorrect: currentCorrect));
    }
  }

  void initQuestion() {
    if (state.model.currentAnswer != null) {
      emit(state.copyWith(currentAnswer: state.model.currentAnswer));
      checkAnswer();
    } else {
      emit(state.copyWith(
        hasChecked: false,
        currentAnswer:
            List.generate(state.model.correctAnswer.length, (index) => ""),
        isCorrect: false,
      ));
    }
  }
}
