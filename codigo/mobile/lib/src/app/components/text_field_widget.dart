import 'package:amigleapp/src/app/utils/styles/colors_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String label;
  final bool password;
  final TextInputType keyBoardType;
  final String errorText;
  final Function(String) onChange;

  TextFieldWidget({
    this.label,
    this.onChange,
    this.password,
    this.keyBoardType,
    this.errorText,
  });

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.password,
      onChanged: (text) {
        widget.onChange(text);
      },
      keyboardType: widget.keyBoardType ?? TextInputType.text,
      cursorColor: ColorsStyle.purple,
      decoration: InputDecoration(
        labelText: widget.label,
        fillColor: ColorsStyle.background,
        errorText: widget.errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.0),
          borderSide: BorderSide(color: ColorsStyle.purple, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.0),
          borderSide: BorderSide(color: ColorsStyle.purple, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.0),
          borderSide: BorderSide(color: ColorsStyle.purple, width: 2),
        ),
        //fillColor: Colors.green
      ),
    );
  }
}
