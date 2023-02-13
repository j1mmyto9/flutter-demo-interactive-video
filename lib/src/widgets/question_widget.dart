import 'package:demovideo/src/video/model/video_model.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget(this.item,
      {this.index,
      required this.expanded,
      this.onTap,
      this.onTapAt,
      super.key});

  final VideoQuestion item;
  final int? index;
  final bool expanded;
  final GestureTapCallback? onTap;
  final Function(int)? onTapAt;

  @override
  Widget build(BuildContext context) {
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
                    item.title,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 8)
                ],
              ),
              if (expanded) const Divider(height: 8),
              if (expanded)
                for (int i = 0; i < item.answers.length; i++)
                  InkWell(
                    onTap: () => onTapAt?.call(i),
                    child: SizedBox(
                      height: 48,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Icon(i == index
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off),
                          ),
                          Text(item.answers[i]),
                        ],
                      ),
                    ),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
