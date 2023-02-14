import 'package:demovideo/src/question/features/fill_blank/cubit/fill_blank_cubit.dart';
import 'package:demovideo/src/question/widgets/q_button_icon.dart';
import 'package:demovideo/src/question/widgets/q_button_text.dart';
import 'package:demovideo/src/question/widgets/q_text_field.dart';
import 'package:demovideo/src/video/model/question/fill_blank_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'helper/zip_helper.dart';

class FillBlankWidget extends StatelessWidget {
  const FillBlankWidget(this.item,
      {required this.expanded, this.onTap, this.onTapAt, super.key});

  final FillBlankModel item;
  final bool expanded;
  final GestureTapCallback? onTap;
  final Function(dynamic)? onTapAt;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FillBlankCubit(item),
      child: BlocBuilder<FillBlankCubit, FillBlankState>(
        buildWhen: (previous, current) => previous.model != current.model,
        builder: (context, state) {
          return InkWell(
            onTap: onTap,
            child: FittedBox(
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(Icons.flag_circle, color: Colors.amber),
                          ),
                          Text(
                            "Fill in the correct ingredients",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 8)
                        ],
                      ),
                      if (expanded) ...[
                        const Divider(height: 8),
                        _fillWidget(context),
                        const SizedBox(height: 10),
                        _checkWidget()
                      ]
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _fillWidget(BuildContext context) {
    List<FocusNode> focusNodes =
        List.generate(item.correctAnswer.length, (index) => FocusNode());
    List<Widget> textFields = List.generate(
        item.correctAnswer.length,
        (index) => BlocBuilder<FillBlankCubit, FillBlankState>(
              buildWhen: (previous, current) =>
                  previous.currentAnswer != current.currentAnswer,
              builder: (context, state) => QTextField(
                focusNode: focusNodes[index],
                onEditComplete: () {
                  if (index + 1 < item.correctAnswer.length - 1) {
                    FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                  }
                },
                initValue: state.currentAnswer[index],
                func: (value) =>
                    context.read<FillBlankCubit>().onChangeField(value, index),
              ),
            ));

    List<String> splitQuestion = item.title.split("***");
    List<Widget> listText = splitQuestion.map((e) => Text(e)).toList();

    final res = ZipHelper.zip<Widget>(listText, textFields).toList();

    return BlocBuilder<FillBlankCubit, FillBlankState>(
      buildWhen: (previous, current) =>
          previous.hasChecked != current.hasChecked,
      builder: (context, state) {
        return SizedBox(
          key: UniqueKey(),
          width: 400,
          child: Wrap(children: res),
        );
      },
    );
  }

  Widget _checkWidget() => BlocBuilder<FillBlankCubit, FillBlankState>(
      buildWhen: (previous, current) =>
          previous.hasChecked != current.hasChecked,
      builder: (context, state) => state.hasChecked
          ? _checkCorrect()
          : QButtonText(
              title: "Check",
              onTap: () => context.read<FillBlankCubit>().checkAnswer()));

  Widget _checkCorrect() => BlocBuilder<FillBlankCubit, FillBlankState>(
      buildWhen: (previous, current) => previous.isCorrect != current.isCorrect,
      builder: (context, state) =>
          state.isCorrect ? _correctWidget() : _inCorrectWidget());

  Widget _inCorrectWidget() => BlocBuilder<FillBlankCubit, FillBlankState>(
      buildWhen: (previous, current) =>
          previous.currentAnswer != current.currentAnswer ||
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
                          context.read<FillBlankCubit>().initQuestion()),
                  QButtonIcon(
                      iconData: Icons.play_arrow,
                      onTap: () => onTapAt?.call(state.currentAnswer)),
                ],
              ),
            ],
          ));

  Widget _correctWidget() => BlocBuilder<FillBlankCubit, FillBlankState>(
      buildWhen: (previous, current) =>
          previous.currentAnswer != current.currentAnswer,
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
                      onTap: () => onTapAt?.call(state.currentAnswer)),
                ],
              ),
            ],
          ));
}
