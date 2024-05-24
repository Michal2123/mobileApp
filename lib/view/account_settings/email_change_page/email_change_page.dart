import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/account_settings/email_change_page/email_change_sections/main_section.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/back_arrow_navigation_widget.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';

class EmailChange extends StatefulWidget {
  const EmailChange({super.key});

  @override
  State<EmailChange> createState() => _EmailChange();
}

class _EmailChange extends State<EmailChange> {
  @override
  Widget build(BuildContext context) {
    return const CustomeScaffold(
      showBottomNavigationBar: false,
      child: BackArrowNavigation(
        view: EmailChangeMainSection(),
      ),
    );
  }
}
