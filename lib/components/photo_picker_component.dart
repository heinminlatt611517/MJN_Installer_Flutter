import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mjn_installer_app/components/label_text_component.dart';

class PhotoPickerComponent extends StatelessWidget {
  PhotoPickerComponent(
      {Key? key, this.onPress,this.text, required this.imagePath})
      : super(key: key);
  final Function()? onPress;
  final String? text;
  final File? imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
          child:
          Column(
            children: [
              LabelTextComponent(text: text!, color: Colors.black38, padding: 0),
              InkWell(
                onTap: onPress,
                child: imagePath != null
                    ? Container(
                  height: 140.0,
                  width: 140.0,
                  child: Image.file(
                    imagePath!,
                    fit: BoxFit.fill,
                  ),
                )
                    : Container(
                    height: 140.0,
                    width: 140.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        )),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 70,
                      color: Colors.grey,
                    )),
              ),
            ],

          ),
    );
  }
}
