import 'package:flutter/material.dart';

mixin FormValidationHelper {
  String? simpleValidaion(String? value) {
    if (value == null || value.isEmpty) {
      return 'Wypełnij pole';
    }
    return null;
  }

  String? textEditingValidation(TextEditingValue? value) {
    return simpleValidaion(value?.text);
  }
}
