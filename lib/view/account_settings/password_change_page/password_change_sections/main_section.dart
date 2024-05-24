import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/service/account_settings_service.dart';
import 'package:flutter_mobile_app/view/account_settings/password_change_page/password_change_sections/form_section.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/sign_button_section.dart';
import 'package:flutter_mobile_app/view/widgets/popups/context_popups.dart';
import 'package:flutter_mobile_app/view/widgets/sign_widgets/form_top_section.dart';

class PasswordChangeMainSection extends StatefulWidget {
  const PasswordChangeMainSection({super.key});

  @override
  State<PasswordChangeMainSection> createState() =>
      _PasswordChangeFormSectionState();
}

class _PasswordChangeFormSectionState extends State<PasswordChangeMainSection> {
  final _accountSettingsService = AccountSettingsService();
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _controllers = {};

  void saveControllersData(Map<String, dynamic> data) {
    _controllers.addAll(data);
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_controllers['newPassword'] != _controllers['repeatNewPassword']) {
        ContextPopups()
            .alertPopup(context, 'Nowe i powtórzone hasło nie są takie same.');
        return;
      }
      _accountSettingsService
          .passwordChange(_controllers['password'], _controllers['newPassword'])
          .then((_) => ContextPopups()
              .alertPopup(context, 'Hasło zostało zmienione pomyślnie'))
          .onError((error, stackTrace) => ContextPopups().alertPopup(context,
              'Nie udało się zmienić hasła.\nNieprawidłowe stare hasło lub coś poszło nie tak.'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        children: [
          const SignFormTopSection(
            tytle: "Stwórz nowe hasło i ciesz się życiem.",
          ),
          PasswordChangeFormSection(
            formKey: _formKey,
            saveControllersData: saveControllersData,
          ),
          SignFormButtonSection(
            tytle: 'Zmień hasło',
            submit: onSubmit,
          ),
        ],
      ),
    );
  }
}
