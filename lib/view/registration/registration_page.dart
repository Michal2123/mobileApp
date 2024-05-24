import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobile_app/view/registration/registration_sections/mian_section.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomeScaffold(
      showBottomNavigationBar: false,
      unfocusFunction: FocusManager.instance.primaryFocus?.unfocus,
      child: const SingleChildScrollView(
        child: RegistrationMainSection(),
      ),
    );
  }
}
