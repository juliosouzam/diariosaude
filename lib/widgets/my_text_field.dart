import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final int maxLines;
  final int minLines;
  final Color color;
  final Color colorForeignground;
  final Icon icon;
  MyTextField({
    this.label,
    this.maxLines = 1,
    this.minLines = 1,
    this.icon,
    this.color,
    this.colorForeignground,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: color != null ? color : Colors.white60),
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
          suffixIcon: icon == null ? null : icon,
          labelText: label,
          labelStyle: TextStyle(color: color != null ? color : Colors.white60),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: colorForeignground != null
                      ? colorForeignground
                      : Colors.white60)),
          border: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: colorForeignground != null
                      ? colorForeignground
                      : Colors.white60))),
    );
  }
}
