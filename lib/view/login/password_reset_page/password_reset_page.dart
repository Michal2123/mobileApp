import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/login/password_reset_page/password_reset_sections/password_reset_form_section.dart';
import 'package:flutter_mobile_app/view/login/password_reset_page/password_reset_sections/password_reset_submit_button_section.dart';
import 'package:flutter_mobile_app/view/login/password_reset_page/password_reset_sections/password_reset_top_section.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomeScaffold(
      showBottomNavigationBar: false,
      unfocusFunction: FocusManager.instance.primaryFocus?.unfocus,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const PasswordResetTopSection(),
            PasswordResetFormSection(
              formKey: _formKey,
              emailController: _emailController,
            ),
            PasswordResetSubmitButtonSection(
              formKey: _formKey,
              emailController: _emailController,
            ),
          ],
        ),
      ),
    );
  }
}
