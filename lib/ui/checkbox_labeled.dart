import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    this.label,
    this.selected,
    this.index,
    this.onChanged,
  });

  final String label;
  final int selected;
  final int index;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(index);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          children: <Widget>[
            Checkbox(
              value: index == selected ? true : false,
              onChanged: onChanged(index),
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}
