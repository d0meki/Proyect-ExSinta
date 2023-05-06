import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  TextEditingController textEditingController;
  Icon icon;
  String label;
  TextInputType typeKeyboard;
  bool hideText;
  bool readOnly;
  Function? validateTextFormField;

  CustomTextFormField(
      this.textEditingController, this.icon, this.label, this.typeKeyboard,
      {this.hideText = false,
      this.validateTextFormField,
      this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: TextFormField(
          controller: textEditingController,
          decoration: InputDecoration(icon: icon, labelText: label),
          keyboardType: typeKeyboard,
          obscureText: hideText,
          readOnly: readOnly,
          validator: (String? value) {
            return validateTextFormField!(value!);
          }),
    );
  }
}

class Validation {
  static isDigit(String s) => (s.codeUnitAt(0) >= 48 && s.codeUnitAt(0) <= 57);

  static soloNumeros(String cad) {
    for (var i = 0; i < cad.length; i++) {
      if (!isDigit(cad[i])) return false;
    }
    return true;
  }

  static cantCaracteres(String str, int cant) {
    if (str.length >= cant) return true;
    return false;
  }
}
