import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class DatePickerComponent extends StatelessWidget {

  final void Function(String) onChangedData;

  const DatePickerComponent(
      {Key? key,
        required this.onChangedData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
      initialValue: '',
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      dateLabelText: 'Date',
      onChanged: (val) => onChangedData(val),
      validator: (val) {
        print(val);
        return null;
      },
      onSaved: (val) => print(val),
    );
  }
}
