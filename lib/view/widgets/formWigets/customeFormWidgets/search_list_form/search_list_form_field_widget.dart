import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/customeFormWidgets/search_list_form/search_list_field_widget.dart';

class SearchListFormField extends FormField<TextEditingValue> {
  SearchListFormField(
      {super.key,
      required bool expand,
      Function()? expandHandlerFunction,
      Widget? child,
      required double minHeigh,
      EdgeInsetsGeometry? margin,
      TextEditingController? controller,
      required List<String> itemsList,
      FocusNode? focusNode,
      super.validator,
      super.onSaved})
      : super(
            initialValue: controller?.value,
            builder: (state) {
              void onChangedHandler(String value) {
                controller?.text = value;
                expand = false;
                state.didChange(controller?.value);
              }

              return Column(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          if (!expand) {
                            expandHandlerFunction?.call();
                          }
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
                            child: SearchListField(
                              controller: controller!,
                              showSearchBreed: expand,
                              selectBreed: onChangedHandler,
                              itemsList: itemsList,
                              searchFocusNode: focusNode,
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
