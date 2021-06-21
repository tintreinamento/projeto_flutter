import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';

class DropDownComponent extends StatefulWidget {
  var value;
  var onChanged;
  var label;
  var items;

  DropDownComponent({Key? key, this.onChanged, this.label, this.items})
      : super(key: key);

  @override
  _DropDownComponentState createState() => _DropDownComponentState();
}

class _DropDownComponentState extends State<DropDownComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<String>(
        value: widget.value,
        //elevation: 5,
        style: TextStyle(color: Colors.black),
        items: <String>[...widget.items]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        hint: TextComponent(
          label: widget.label,
        ),
        onChanged: (value) {
          widget.onChanged(value);
        },
      ),
    );
  }
}
