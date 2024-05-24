import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobile_app/view/login/login_page/login_sections/main_section.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomeScaffold(
      showBottomNavigationBar: false,
      child: SingleChildScrollView(
        child: LoginMainSection(),
      ),
    );
  }
}
