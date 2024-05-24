import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_form_page/missing_pet_form_sections/main_section.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';

class MissingPetForm extends StatefulWidget {
  const MissingPetForm({super.key});

  @override
  State<MissingPetForm> createState() => _MissingPetFormState();
}

class _MissingPetFormState extends State<MissingPetForm> {
  @override
  Widget build(BuildContext context) {
    return CustomeScaffold(
      showBottomNavigationBar: false,
      unfocusFunction: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: const MissingPetFormMainSection(),
    );
  }
}
