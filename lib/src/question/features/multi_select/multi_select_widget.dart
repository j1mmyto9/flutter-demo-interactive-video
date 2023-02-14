import 'package:demovideo/src/question/widgets/q_button_icon.dart';
import 'package:demovideo/src/question/widgets/q_button_text.dart';
import 'package:demovideo/src/video/model/question/multi_select_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/multi_select_cubit.dart';

class MultiSelectWidget extends StatelessWidget {
  const MultiSelectWidget(this.item,
      {required this.expanded, this.onTap, this.onTapAt, super.key});

  final MultiSelectModel item;
  final bool expanded;
  final GestureTapCallback? onTap;
  final Function(dynamic)? onTapAt;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MultiSelectCubit(item),
      child: BlocBuilder<MultiSelectCubit, MultiSelectState>(
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

  Widget _listChoice() => BlocBuilder<MultiSelectCubit, MultiSelectState>(
        buildWhen: (previous, current) =>
            previous.currentSelects != current.currentSelects ||
            previous.hasChecked != current.hasChecked,
        builder: (context, state) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: state.model.answers
                  .map((e) => InkWell(
                        onTap: state.hasChecked
                            ? () {}
                            : () => context
                                .read<MultiSelectCubit>()
                                .selectChoice(e),
                        child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color: state.currentSelects.contains(e)
                                    ? Colors.blue.shade400
                                    : null),
                            child: Text(e)),
                      ))
                  .toList());
        },
      );

  Widget _checkWidget() => BlocBuilder<MultiSelectCubit, MultiSelectState>(
      buildWhen: (previous, current) =>
          previous.hasChecked != current.hasChecked,
      builder: (context, state) => state.hasChecked
          ? _checkCorrect()
          : QButtonText(
              title: "Check",
              onTap: () => context.read<MultiSelectCubit>().checkAnswer()));

  Widget _checkCorrect() => BlocBuilder<MultiSelectCubit, MultiSelectState>(
      buildWhen: (previous, current) => previous.isCorrect != current.isCorrect,
      builder: (context, state) =>
          state.isCorrect ? _correctWidget() : _inCorrectWidget());

  Widget _inCorrectWidget() => BlocBuilder<MultiSelectCubit, MultiSelectState>(
      buildWhen: (previous, current) =>
          previous.currentSelects != current.currentSelects ||
          previous.currentCorrect != current.currentCorrect,
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
                  Text(
                      "${state.currentCorrect.length}/${state.model.correctAnswer.length}"),
                  QButtonIcon(
                      iconData: Icons.replay,
                      onTap: () =>
                          context.read<MultiSelectCubit>().initQuestion()),
                  QButtonIcon(
                      iconData: Icons.play_arrow,
                      onTap: () => onTapAt?.call(state.currentSelects)),
                ],
              ),
            ],
          ));

  Widget _correctWidget() => BlocBuilder<MultiSelectCubit, MultiSelectState>(
      buildWhen: (previous, current) =>
          previous.currentSelects != current.currentSelects,
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
                  Text(
                      "${state.model.correctAnswer.length}/${state.model.correctAnswer.length}"),
                  QButtonIcon(
                      iconData: Icons.play_arrow,
                      onTap: () => onTapAt?.call(state.currentSelects)),
                ],
              ),
            ],
          ));
}
