import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/login/login_page/login_sections/bottom_item_section.dart';
import 'package:flutter_mobile_app/view/login/password_reset_page/password_reset_page.dart';
import 'package:flutter_mobile_app/view/registration/registration_page.dart';

class LoginBottomListSection extends StatelessWidget {
  const LoginBottomListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          LoginBottomItemSection(
            title: 'Nie pamiętasz hasła?',
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const PasswordReset())),
          ),
          LoginBottomItemSection(
            title: 'Nie masz konta?',
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Registration())),
          ),
        ],
      ),
    );
  }
}
