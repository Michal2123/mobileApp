import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/service/account_settings_service.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/sign_button_section.dart';
import 'package:flutter_mobile_app/view/account_settings/email_change_page/email_change_sections/form_section.dart';
import 'package:flutter_mobile_app/view/widgets/sign_widgets/form_top_section.dart';
import 'package:flutter_mobile_app/view/widgets/popups/context_popups.dart';

class EmailChangeMainSection extends StatefulWidget {
  const EmailChangeMainSection({super.key});

  @override
  State<EmailChangeMainSection> createState() => _EmailChangeFormSectionState();
}

class _EmailChangeFormSectionState extends State<EmailChangeMainSection> {
  final Map<String, dynamic> _controller = {};
  final _formKey = GlobalKey<FormState>();

  final _accountSettingsService = AccountSettingsService();

  void saveControllerData(Map<String, dynamic> controllerData) {
    _controller.addAll(controllerData);
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _accountSettingsService
          .emailChange(_controller['email'])
          .then((_) => ContextPopups().alertPopup(context,
              'Na podany adres Email zostanie wysłana wiadomość z linkiem potwierdzającym zmianę maila.'))
          .onError((error, stackTrace) => ContextPopups()
              .alertPopup(context, 'Nie udało się zmienić adresu Email'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SignFormTopSection(
          tytle: "Zmiana adresu Email.",
        ),
        EmailChangeFormSection(
          formKey: _formKey,
          saveControllerData: saveControllerData,
        ),
        SignFormButtonSection(
          tytle: 'Zmień adres Email',
          submit: onSubmit,
        ),
      ],
    );
  }
}
