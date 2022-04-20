import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
class LabelTextComponent extends StatelessWidget {
  LabelTextComponent({
    Key? key,
    required this.text,
    required this.color,
    required this.padding,
    this.containerWidth
  }) : super(key: key);

  final String text;
  final Color color;
  final double padding;
  double? containerWidth;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(padding),
      child: Container(
        width: containerWidth,
        child: AutoSizeText(
          text,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color:color,
              decoration: TextDecoration.none),
          overflow: TextOverflow.fade,
          maxLines: null,
          softWrap: true,
        ),
      ),
    );
  }
}
