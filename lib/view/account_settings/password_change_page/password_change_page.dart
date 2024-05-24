import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobile_app/view/account_settings/password_change_page/password_change_sections/main_section.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/back_arrow_navigation_widget.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';

class PasswordChange extends StatefulWidget {
  const PasswordChange({super.key});

  @override
  State<PasswordChange> createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  @override
  Widget build(BuildContext context) {
    return CustomeScaffold(
      unfocusFunction: FocusManager.instance.primaryFocus?.unfocus,
      showBottomNavigationBar: false,
      child: const BackArrowNavigation(
        view: SingleChildScrollView(
          child: PasswordChangeMainSection(),
        ),
      ),
    );
  }
}
