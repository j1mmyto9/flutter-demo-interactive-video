import 'package:bloc/bloc.dart';
import 'package:demovideo/src/video/model/question/multi_choice_model.dart';
import 'package:equatable/equatable.dart';

part 'multi_choice_state.dart';

class MultiChoiceCubit extends Cubit<MultiChoiceState> {
  MultiChoiceCubit(MultiChoiceModel multiChoiceModel)
      : super(MultiChoiceState(model: multiChoiceModel)) {
    initQuestion();
  }

  void selectChoice(int value) => emit(state.copyWith(currentChoice: value));

  void checkAnswer() => emit(state.copyWith(
      isCorrect: state.model.correctAnswer == state.currentChoice,
      hasChecked: true));

  void initQuestion() {
    if (state.model.indexCurrent != null) {
      emit(state.copyWith(
          hasChecked: true,
          currentChoice: state.model.indexCurrent,
          isCorrect: state.model.correctAnswer == state.model.indexCurrent,
          showAnswer: false));
    } else {
      emit(state.copyWith(
          hasChecked: false,
          currentChoice: -1,
          isCorrect: false,
          showAnswer: false));
    }
  }

  void showAnswer() => emit(state.copyWith(showAnswer: true));
}
