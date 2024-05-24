import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/customeFormWidgets/tag_picker_form/tag_picker_field.dart';

class TagPickerFormField extends FormField<List<String>> {
  TagPickerFormField({
    super.key,
    required final String title,
    required final double minHeigh,
    required final EdgeInsets margin,
    required final bool expand,
    required Function expandHandlerFunction,
    required Function(String) tagHandlerFunction,
    final TextEditingController? controller,
    required final List<String> tagList,
    required final List<String> selectTagList,
    super.validator,
  }) : super(
            initialValue: selectTagList,
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
                                      : expand
                                          ? ColorConstant.inputFocusBorderColor
                                          : ColorConstant.inputBorderColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              color: ColorConstant.inputBorderColor,
                            ),
                            child: TagPickerField(
                              title: title,
                              expand: expand,
                              tagHandlerFunction: tagHandlerFunction,
                              tagList: tagList,
                              selectedTagList: selectTagList,
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
