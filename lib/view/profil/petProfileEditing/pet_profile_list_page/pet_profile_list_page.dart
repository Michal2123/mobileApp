import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:flutter_mobile_app/view/profil/petProfileEditing/edit_pet_profile_page/edit_pet_profile_page.dart';
import 'package:flutter_mobile_app/view/profil/petProfileEditing/pet_profile_list_page/pet_profile_list_sections/pet_list_section.dart';
import 'package:flutter_mobile_app/view/profil/profile_page/profile_page.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/back_arrow_navigation_widget.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/setting_text_button.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';

class PetProfileList extends StatefulWidget {
  const PetProfileList({super.key});

  @override
  State<PetProfileList> createState() => _PetProfileListState();
}

class _PetProfileListState extends State<PetProfileList> {
  @override
  Widget build(BuildContext context) {
    return CustomeScaffold(
      showBottomNavigationBar: false,
      child: BackArrowNavigation(
        navigatorFunction: () => Navigator.of(context).push(MaterialPageRoute(
            settings: RouteSettings(name: MainPages.profilePage.name),
            builder: (context) => const Profile())),
        view: Padding(
          padding:
              const EdgeInsets.only(left: 15, top: 100, right: 15, bottom: 5),
          child: Column(
            children: [
              SettingTextButton(
                labelText: 'Dodaj profil psa',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const EditPetProfile())),
              ),
              const PetProfileListSection()
            ],
          ),
        ),
      ),
    );
  }
}
