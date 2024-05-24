import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/login/login_page/login_page.dart';
import 'package:flutter_mobile_app/view/registration/registration_sections/info_item_section.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/sign_button_section.dart';

class RegistrationInfoSection extends StatelessWidget {
  const RegistrationInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
      child: Column(
        children: [
          const RegistrationInfoItemSection(
            text: 'Konto zostało utworzone.',
          ),
          const RegistrationInfoItemSection(
            text: 'Na podany adres Email został wysłany link aktywacyjny.',
          ),
          const RegistrationInfoItemSection(
            text: 'Kliknij w link aby aktywować konto.',
          ),
          SignFormButtonSection(
              tytle: 'Przejdź do strony logowania',
              submit: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Login()),
                  ))
        ],
      ),
    );
  }
}
