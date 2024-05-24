import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/edit_dog_service.dart';
import 'package:flutter_mobile_app/view/profil/petProfileEditing/pet_profile_list_page/pet_profile_list_sections/pet_section.dart';

class PetProfileListSection extends StatefulWidget {
  const PetProfileListSection({super.key});

  @override
  State<PetProfileListSection> createState() => _PetProfileListSectionState();
}

class _PetProfileListSectionState extends State<PetProfileListSection> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.only(top: 25),
        children: [
          for (var pet in context.watch<EditDogService>().dogsList)
            PetProfileListPetSection(
              pet: pet,
            )
        ],
      ),
    );
  }
}
