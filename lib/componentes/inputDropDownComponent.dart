import 'package:flutter/material.dart';
import 'package:projeto_flutter/componentes/DropDownComponent.dart';
import 'package:projeto_flutter/componentes/TextComponent.dart';

class InputDropDownComponent extends StatefulWidget {
  var label;
  var onChanged;
  var labelDropDown;
  var items;

  InputDropDownComponent(
      {Key? key, this.label, this.onChanged, this.labelDropDown, this.items})
      : super(key: key);

  @override
  _InputDropDownComponentState createState() => _InputDropDownComponentState();
}

class _InputDropDownComponentState extends State<InputDropDownComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: TextComponent(
            label: widget.label,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          flex: 5,
          child: DropDownComponent(
            label: widget.labelDropDown,
            items: widget.items,
            onChanged: widget.onChanged,
          ),
        )
      ],
    ));
  }
}
