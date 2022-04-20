import 'package:flutter/material.dart';
class ButtonComponent extends StatelessWidget {
  ButtonComponent({
    Key? key,
    required this.text,
    required this.color,
    required this.padding,
    this.containerWidth,
    this.onPress,
  }) : super(key: key);
  final String text;
  final Function()? onPress;
  final Color color;
  final double padding;
  final double? containerWidth;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPress,
        child: Container(
          alignment: Alignment.center,
          width: containerWidth,
          child: Padding(
            padding:  EdgeInsets.all(padding),
            child: Text(text,style: TextStyle(color: Colors.white),),
          ),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
        ));
  }
}
