import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kiwi/kiwi.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/helper/mixins/cache_data_mixin.dart';
import 'package:flutter_mobile_app/main.dart';
import 'package:flutter_mobile_app/service/edit_dog_service.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/view/account_settings/account_page/account_page.dart';
import 'package:flutter_mobile_app/view/profil/petProfileEditing/pet_profile_list_page/pet_profile_list_page.dart';
import 'package:flutter_mobile_app/view/profil/userProfilEditing/edit_user_profile_page.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/setting_text_button.dart';

class ProfileButtonSection extends StatelessWidget with CacheData {
  ProfileButtonSection({super.key});
  final _storage = KiwiContainer().resolve<FlutterSecureStorage>();

  void signOut(BuildContext context) {
    Future.wait([
      context.read<MessangerConnectionService>().closeConnection(),
      clearCache(),
      _storage.deleteAll()
    ]).then((_) => navigatorKey.currentState!.pushNamed('login'));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingTextButton(
          labelText: 'Edytuj profil',
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const EditUserProfile())),
        ),
        SettingTextButton(
          padding: const EdgeInsets.only(top: 15),
          labelText: 'Edytuj profil psa',
          onTap: () {
            context.read<EditDogService>().get();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const PetProfileList()));
          },
        ),
        SettingTextButton(
          padding: const EdgeInsets.only(top: 15),
          labelText: 'Konto',
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const Account(),
              settings: RouteSettings(name: MainPages.profilePage.name))),
        ),
        SettingTextButton(
          padding: const EdgeInsets.only(top: 15),
          labelText: 'Wyloguj',
          onTap: () => signOut(context),
        ),
      ],
    );
  }
}
