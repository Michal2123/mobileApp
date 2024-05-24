import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/customeFormWidgets/date_picker_form/date_picker_field_widget.dart';

class DatePickerFormField extends FormField<TextEditingValue> {
  DatePickerFormField(
      {super.key,
      required double minHeigh,
      EdgeInsets? margin,
      required bool expand,
      required TextEditingController controller,
      required Function expandHandlerFunction,
      FocusNode? focusNode,
      final List<TextInputFormatter>? textInputFormatterList,
      required String title,
      String? inputMastType,
      super.validator,
      super.onSaved})
      : super(
            initialValue: controller.value,
            builder: (state) {
              void onChangedHandler(String value) {
                state.didChange(controller.value);
              }

              return Column(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          expandHandlerFunction();
                        },
                        child: AnimatedContainer(
                            constraints: BoxConstraints(
                                minHeight: minHeigh, minWidth: double.infinity),
                            margin: margin,
                            duration: const Duration(milliseconds: 100),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: state.hasError
                                      ? ColorConstant.inputErrorBorderColor
                                      : expand
                                          ? ColorConstant.inputFocusBorderColor
                                          : ColorConstant.inputBorderColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              color: ColorConstant.inputBorderColor,
                            ),
                            child: DatePickerField(
                              title: title,
                              controller: controller,
                              expand: expand,
                              missingDateFocusNode: focusNode,
                              onChange: onChangedHandler,
                              inputMastType: inputMastType,
                              textInputFormatterList: textInputFormatterList,
                            )),
                      )),
                  if (state.hasError) ...[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, left: 10),
                        child: Text('Wypełnij pole',
                            style: TextStyle(
                                color: ColorConstant.inputErrorBorderColor,
                                fontSize: 12)),
                      ),
                    ),
                  ]
                ],
              );
            });
}
