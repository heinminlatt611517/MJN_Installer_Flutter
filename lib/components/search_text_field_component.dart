import 'package:flutter/material.dart';
class SearchTextFieldComponent extends StatelessWidget {
  SearchTextFieldComponent({
    Key? key,
    this.hintText,
    this.maxLines = 3,
    this.errorText,
    this.textInputType = TextInputType.text,
    this.icon,
    this.isVisible = false,
    this.onTap,
    this.onTextDataChange,
   required this.controller,
    this.onPressIcon,
  }) : super(key: key);
  final String? hintText;
  final int? maxLines;
  final String? errorText;
  final IconData? icon;
  final bool isVisible;
  final Function()? onPressIcon;
  final Function()? onTap;
  final  Function(String)? onTextDataChange;
  final TextInputType textInputType;
  final TextEditingController controller;
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.1-60, ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
          border: Border.all(color: Colors.grey)
      ),
      child: TextFormField(
        onChanged: (String value){
           onTextDataChange!(value);
        },
        onTap: onTap,
        maxLines: null,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.multiline,
        controller: controller,
        obscureText: isVisible,
        style: TextStyle(fontSize: 10),
        decoration: InputDecoration(
          suffixIconConstraints: BoxConstraints(
              minHeight: 5,
              minWidth: 5
          ),
          border: InputBorder.none,
          suffixIcon: Align(
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: InkWell(child: Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Icon(icon),
              ), onTap:onPressIcon,)),
          isDense: true,
          contentPadding: EdgeInsets.only(left: 10,bottom: 14,top: 10),
        ),
        validator: (value) => value!.trim().isEmpty ? errorText : null,
      ),
    );
  }

}