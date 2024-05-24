import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/service/registration_service.dart';
import 'package:flutter_mobile_app/view/registration/registration_sections/bottom_section.dart';
import 'package:flutter_mobile_app/view/registration/registration_sections/form_section.dart';
import 'package:flutter_mobile_app/view/registration/registration_sections/info_section.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/sign_button_section.dart';
import 'package:flutter_mobile_app/view/widgets/popups/context_popups.dart';
import 'package:flutter_mobile_app/view/widgets/sign_widgets/form_top_section.dart';

class RegistrationMainSection extends StatefulWidget {
  const RegistrationMainSection({super.key});

  @override
  State<RegistrationMainSection> createState() =>
      _RegistrationMainSectionState();
}

class _RegistrationMainSectionState extends State<RegistrationMainSection> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _controllers = {};
  final RegistrationService _registrationService = RegistrationService();
  final ContextPopups _contextPopups = ContextPopups();

  bool _isRegistrationSucces = false;
  bool _isLoading = false;

  void saveControllerData(Map<String, dynamic> data) {
    _controllers.addAll(data);
  }

  void loading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      loading();
      _registrationService
          .register(_controllers['emain'], _controllers['password'],
              _controllers['login'])
          .then((_) {
        loading();
        setState(() {
          _isRegistrationSucces = !_isRegistrationSucces;
        });
      }).onError((error, stackTrace) {
        loading();
        _contextPopups.alertPopup(context,
            'Nie udało się stworzyć konta.\nPodany mail lub login już istnieją.');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SignFormTopSection(
          tytle: "Dołącz do społeczności psiapp",
          hideTytle: _isRegistrationSucces,
        ),
        _isRegistrationSucces
            ? const RegistrationInfoSection()
            : Column(
                children: [
                  RegistrationFormSection(
                    saveControllersData: saveControllerData,
                    formKey: _formKey,
                  ),
                  SignFormButtonSection(
                    tytle: 'Zarejestruj się',
                    submit: onSubmit,
                    isLoading: _isLoading,
                  ),
                  const RegistrationBottomSection()
                ],
              ),
      ],
    );
  }
}
