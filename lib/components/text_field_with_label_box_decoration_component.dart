import 'package:flutter/material.dart';
class TextFieldWithLabelBoxDecorationComponent extends StatelessWidget {
  TextFieldWithLabelBoxDecorationComponent({
    Key? key,
    required this.hintText,
    this.maxLines = 1,
    required this.errorText,
    this.textInputType = TextInputType.text,
    this.icon,
    this.isVisible = false,
   required this.controller,
    this.onPress,
    required this.labelText
  }) : super(key: key);
  final String hintText;
  final int maxLines;
  final String errorText;
  final IconData? icon;
  final bool isVisible;
  final Function()? onPress;
  final TextInputType textInputType;
  final TextEditingController controller;
  final String labelText;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 35,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        child: Row(
          children: [
            Expanded(child: Text(labelText,style: TextStyle(fontSize: 10),)),
            Flexible(
              flex: 2,
              child: TextFormField(
                maxLines: maxLines,
                textInputAction: TextInputAction.next,
                keyboardType: textInputType,
                controller: controller,
                obscureText: isVisible,
                decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.all(10),
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))),
                validator: (value) => value!.trim().isEmpty ? errorText : null,
              ),
            ),
          ],

        )
      ),
    );
  }
}