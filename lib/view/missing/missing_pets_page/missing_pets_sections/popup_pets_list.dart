import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/edit_dog_service.dart';
import 'package:flutter_mobile_app/service/missing_dog_service.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_form_page/missing_pet_form_page.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class MissingPetsPopupPetsList extends StatelessWidget {
  const MissingPetsPopupPetsList({super.key});

  void selectItem(BuildContext context, [String? petName]) {
    context.read<MissingDogService>().clearData();
    context.read<MissingDogService>().petName = petName;
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const MissingPetForm()));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
      title: const Align(
        alignment: Alignment.center,
        child: InputLabelText(
          text: 'Wybierz zwierzaka',
          fontSize: 24,
        ),
      ),
      backgroundColor: ColorConstant.backgroundScaffoldColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
            direction: Axis.horizontal,
            runSpacing: 10,
            spacing: 10,
            alignment: context.read<EditDogService>().dogsList.isNotEmpty
                ? WrapAlignment.start
                : WrapAlignment.center,
            children: [
              for (var pet in context.read<EditDogService>().dogsList)
                GestureDetector(
                  onTap: () => selectItem(context, pet.name),
                  child: Column(
                    children: [
                      const FlutterLogo(
                        size: 150,
                      ),
                      InputLabelText(text: pet.name)
                    ],
                  ),
                ),
              GestureDetector(
                onTap: () => selectItem(context),
                child: Column(
                  children: [
                    DottedBorder(
                      color: ColorConstant.defaultTextColor,
                      strokeWidth: 2,
                      dashPattern: const [7, 10],
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 35, top: 40, right: 35, bottom: 40),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.add_circle_rounded,
                                      color: ColorConstant.activeButton,
                                      size: 40,
                                    ),
                                  )))),
                    ),
                    const InputLabelText(text: 'nowy')
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
