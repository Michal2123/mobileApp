import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/missing/missing_pets_page/missing_pets_sections/popup_pets_list.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class MissingPetsAddButtonSection extends StatelessWidget {
  const MissingPetsAddButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return const MissingPetsPopupPetsList();
            },
          );
        },
        child: SizedBox(
          height: 50,
          child: Card(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_rounded,
                    color: ColorConstant.activeButton,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const InputLabelText(text: 'Dodaj zgłoszenie'),
                ]),
          ),
        ),
      ),
    );
  }
}
