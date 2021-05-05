import 'package:amigleapp/src/app/utils/styles/colors_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextFieldWidget extends StatefulWidget {
  final String label;
  final bool password;
  final TextInputType keyBoardType;
  final String errorText;
  final Function(String) onChange;
  final String mask;
  final TextEditingController controller;

  TextFieldWidget(
      {this.label,
      this.onChange,
      this.password,
      this.keyBoardType,
      this.errorText,
      this.mask,
      this.controller});

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.password,
      onChanged: (text) {
        widget.onChange(text);
      },
      inputFormatters: this._getFormatters(),
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

  List<TextInputFormatter> _getFormatters() {
    List<TextInputFormatter> list = [];
    if (this.widget.mask != null) {
      var maskFormatter = new MaskTextInputFormatter(
          mask: this.widget.mask, filter: {"#": RegExp(r'[0-9]')});
      list.add(maskFormatter);
    }

    return list;
  }
}
