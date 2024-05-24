import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_form_page/missing_pet_form_sections/main_section.dart';
import 'package:flutter_mobile_app/view/profil/userProfilEditing/user_profile_editing_sections/main_section.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({super.key});
  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  final _formMainSectionController = FormMainSectionController();

  @override
  Widget build(BuildContext context) {
    return CustomeScaffold(
        showBottomNavigationBar: false,
        unfocusFunction: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: EditUserMainSection(
          formMainSectionController: _formMainSectionController,
        ));
  }
}
