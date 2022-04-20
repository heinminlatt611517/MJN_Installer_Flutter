import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class DropDownButtonComponent<T> extends StatelessWidget {
  final List<dynamic>? itemsList;
  final List<dynamic>? installItemsList;
  final IconData? icon;
  final String? value;
  final String? hintText;
  final void Function(T) onChangedData;
  final String? status;
  const DropDownButtonComponent(
      {Key? key,
      this.itemsList = const [],
      this.installItemsList = const [],
      this.icon,
      this.value,
        this.status,
      required this.hintText,
      required this.onChangedData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: 40
      ),
      child: SafeArea(
        child: DropdownButtonFormField2<dynamic>(
          isExpanded: true,
          isDense: false,
          itemHeight: 30,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),

            ),
          ),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.black45,
          ),
          iconSize: 33,
          buttonHeight: 40,
          dropdownMaxHeight: 190,
          scrollbarAlwaysShow: true,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          items:  itemsList
              !.map((items) => DropdownMenuItem(
                    child: Center(
                      child: Text(
                        items.name.toString(),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54, fontSize: 10),
                      ),
                    ),
                    value: items,
                  ))
              .toList(),
          onChanged: (value) {
            onChangedData(value);
          },
          hint: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              hintText.toString(),
              style: TextStyle(fontSize: 10, color: Colors.black54),
            ),
          ),
        ),
      ),
    );
  }
}
