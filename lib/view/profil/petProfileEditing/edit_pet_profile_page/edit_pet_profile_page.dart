import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_form_page/missing_pet_form_sections/main_section.dart';
import 'package:flutter_mobile_app/view/profil/petProfileEditing/edit_pet_profile_page/edit_pet_profile_sections/main_section.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';

class EditPetProfile extends StatefulWidget {
  const EditPetProfile({super.key, this.dogId});
  final String? dogId;

  @override
  State<EditPetProfile> createState() => _EditPetProfileState();
}

class _EditPetProfileState extends State<EditPetProfile> {
  final FormMainSectionController _formMainSectionController =
      FormMainSectionController();

  @override
  Widget build(BuildContext context) {
    return CustomeScaffold(
        showBottomNavigationBar: false,
        unfocusFunction: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: EditPetProfileMainSection(
          dogId: widget.dogId,
          formMainSectionController: _formMainSectionController,
        ));
  }
}
