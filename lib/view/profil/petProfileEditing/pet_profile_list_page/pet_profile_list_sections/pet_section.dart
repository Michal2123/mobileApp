import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/model/edit_profile_models/dog_model.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/profil/petProfileEditing/pet_profile_list_page/pet_profile_list_sections/delete_pet_section.dart';
import 'package:flutter_mobile_app/view/profil/petProfileEditing/pet_profile_list_page/pet_profile_list_sections/edit_pet_section.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class PetProfileListPetSection extends StatefulWidget {
  const PetProfileListPetSection({super.key, required this.pet});
  final GetDogModel pet;

  @override
  State<PetProfileListPetSection> createState() =>
      _PetProfileListPetSectionState();
}

class _PetProfileListPetSectionState extends State<PetProfileListPetSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Expanded(child: InputLabelText(text: widget.pet.name)),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              height: 75,
              child: Row(
                children: [
                  PetProfileListEditPetSection(
                    petId: widget.pet.dogId,
                  ),
                  VerticalDivider(
                    color: ColorConstant.petPhotoPlaceholderColor,
                    thickness: 2,
                    width: 1,
                    endIndent: 10,
                    indent: 10,
                  ),
                  PetProfileListDeletePetSection(
                    petId: widget.pet.dogId,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
