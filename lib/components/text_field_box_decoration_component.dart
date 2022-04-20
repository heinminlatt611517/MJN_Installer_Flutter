import 'package:flutter/material.dart';
class TextFieldBoxDecorationComponent extends StatelessWidget {
  TextFieldBoxDecorationComponent({
    Key? key,
    required this.hintText,
    this.maxLines = 1,
    required this.errorText,
    this.textInputType = TextInputType.text,
    this.icon,
    this.isVisible = false,
   required this.controller,
    this.onPress,
  }) : super(key: key);
  final String hintText;
  final int maxLines;
  final String errorText;
  final IconData? icon;
  final bool isVisible;
  final Function()? onPress;
  final TextInputType textInputType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
      ),
      child: TextFormField(
        maxLines: null,
        textInputAction: TextInputAction.next,
        keyboardType: textInputType,
        controller: controller,

        obscureText: isVisible,
        style: TextStyle(fontSize: 12),
        decoration: InputDecoration(
            hintText: '',
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(10, 25, 10, 0),
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))),
        validator: (value) => value!.trim().isEmpty ? errorText : null,
      ),
    );
  }
}