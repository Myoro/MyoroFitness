import 'package:flutter/services.dart';

class CalorieInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return const TextEditingValue(
        text: '0',
        selection: TextSelection.collapsed(offset: 1),
      );
    }

    if (newValue.text != '0' && oldValue.text == '0') {
      return TextEditingValue(
        text: newValue.text[newValue.text.length - 1],
        selection: const TextSelection.collapsed(offset: 1),
      );
    }

    if (RegExp(r'^[0-9]{0,5}$').hasMatch(newValue.text)) {
      return newValue;
    }

    return oldValue;
  }
}
