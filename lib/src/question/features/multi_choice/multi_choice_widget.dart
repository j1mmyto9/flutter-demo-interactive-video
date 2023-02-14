import 'package:demovideo/src/question/features/multi_choice/cubit/multi_choice_cubit.dart';
import 'package:demovideo/src/question/widgets/q_button_icon.dart';
import 'package:demovideo/src/question/widgets/q_button_text.dart';
import 'package:demovideo/src/video/model/question/multi_choice_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiChoiceWidget extends StatelessWidget {
  const MultiChoiceWidget(this.item,
      {this.index,
      required this.expanded,
      this.onTap,
      this.onTapAt,
      super.key});

  final MultiChoiceModel item;
  final int? index;
  final bool expanded;
  final GestureTapCallback? onTap;
  final Function(int)? onTapAt;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MultiChoiceCubit(item),
      child: BlocBuilder<MultiChoiceCubit, MultiChoiceState>(
        buildWhen: (previous, current) => previous.model != current.model,
        builder: (context, state) {
          return GestureDetector(
            onTap: onTap,
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Icon(Icons.flag_circle, color: Colors.amber),
                        ),
                        Text(
                          state.model.title,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 8)
                      ],
                    ),
                    if (expanded) ...[
                      const Divider(height: 8),
                      _listChoice(),
                      _checkWidget()
                    ]
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _listChoice() => BlocBuilder<MultiChoiceCubit, MultiChoiceState>(
        buildWhen: (previous, current) =>
            previous.currentChoice != current.currentChoice ||
            previous.showAnswer != current.showAnswer ||
            previous.hasChecked != current.hasChecked,
        builder: (context, state) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  state.model.answers.length,
                  (i) => InkWell(
                        onTap: state.hasChecked
                            ? () {}
                            : () => context
                                .read<MultiChoiceCubit>()
                                .selectChoice(i),
                        child: SizedBox(
                          height: 48,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Icon(i == state.currentChoice
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_off),
                              ),
                              Text(item.answers[i]),
                              if (state.showAnswer &&
                                  i == state.model.correctAnswer)
                                const Icon(Icons.check, color: Colors.green)
                            ],
                          ),
                        ),
                      )));
        },
      );

  Widget _checkWidget() => BlocBuilder<MultiChoiceCubit, MultiChoiceState>(
      buildWhen: (previous, current) =>
          previous.hasChecked != current.hasChecked,
      builder: (context, state) => state.hasChecked
          ? _checkCorrect()
          : QButtonText(
              title: "Check",
              onTap: () => context.read<MultiChoiceCubit>().checkAnswer()));

  Widget _checkCorrect() => BlocBuilder<MultiChoiceCubit, MultiChoiceState>(
      buildWhen: (previous, current) => previous.isCorrect != current.isCorrect,
      builder: (context, state) =>
          state.isCorrect ? _correctWidget() : _inCorrectWidget());

  Widget _inCorrectWidget() => BlocBuilder<MultiChoiceCubit, MultiChoiceState>(
      buildWhen: (previous, current) =>
          previous.showAnswer != current.showAnswer ||
          previous.currentChoice != current.currentChoice,
      builder: (context, state) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Incorrect", style: TextStyle(color: Colors.red)),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.grey,
                  ),
                  const Text("0/1"),
                  if (!state.showAnswer)
                    QButtonIcon(
                        iconData: Icons.remove_red_eye,
                        onTap: () =>
                            context.read<MultiChoiceCubit>().showAnswer()),
                  QButtonIcon(
                      iconData: Icons.replay,
                      onTap: () =>
                          context.read<MultiChoiceCubit>().initQuestion()),
                  QButtonIcon(
                      iconData: Icons.play_arrow,
                      onTap: () => onTapAt?.call(state.currentChoice)),
                ],
              ),
            ],
          ));

  Widget _correctWidget() => BlocBuilder<MultiChoiceCubit, MultiChoiceState>(
      buildWhen: (previous, current) =>
          previous.currentChoice != current.currentChoice,
      builder: (context, state) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Correct", style: TextStyle(color: Colors.green)),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  const Text("1/1"),
                  QButtonIcon(
                      iconData: Icons.play_arrow,
                      onTap: () => onTapAt?.call(state.currentChoice)),
                ],
              ),
            ],
          ));
}
