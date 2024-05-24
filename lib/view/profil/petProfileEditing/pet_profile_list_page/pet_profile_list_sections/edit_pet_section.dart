import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/edit_dog_service.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/profil/petProfileEditing/edit_pet_profile_page/edit_pet_profile_page.dart';

class PetProfileListEditPetSection extends StatelessWidget {
  const PetProfileListEditPetSection({super.key, required this.petId});
  final String petId;

  void onEdit(BuildContext context, String id) {
    context.read<EditDogService>().getDetails(id);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditPetProfile(
              dogId: id,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () => onEdit(context, petId),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Icon(
              Icons.edit,
              size: 24,
              color: ColorConstant.inkWellTextColor,
            )),
      ),
    );
  }
}
