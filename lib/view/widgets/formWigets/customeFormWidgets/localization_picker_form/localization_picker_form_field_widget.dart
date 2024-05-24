import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/customeFormWidgets/localization_picker_form/localization_picker_field_widget.dart';

class LocalizationPickerFormField extends FormField<TextEditingValue> {
  LocalizationPickerFormField({
    super.key,
    required double minHeigh,
    EdgeInsets? margin,
    required TextEditingController controller,
    required Function expandHandlerFunction,
    required String title,
    super.validator,
  }) : super(
            initialValue: controller.value,
            builder: (state) {
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
                                      : ColorConstant.inputBorderColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              color: ColorConstant.inputBorderColor,
                            ),
                            child: LocalizationPickerField(
                              title: title,
                              controller: controller,
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
