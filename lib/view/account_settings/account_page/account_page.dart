import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/setting_text_button.dart';
import 'package:flutter_mobile_app/view/account_settings/email_change_page/email_change_page.dart';
import 'package:flutter_mobile_app/view/account_settings/password_change_page/password_change_page.dart';
import 'package:flutter_mobile_app/view/account_settings/settings_page/settings_page.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/back_arrow_navigation_widget.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';

class Account extends StatelessWidget {
  const Account({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomeScaffold(
      child: BackArrowNavigation(
        view: Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 100, right: 15, bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SettingTextButton(
                  labelText: 'Zmień adres Email',
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const EmailChange())),
                ),
                SettingTextButton(
                  labelText: 'Zmień hasło',
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PasswordChange())),
                ),
                SettingTextButton(
                  labelText: 'Ustawienia',
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Settings())),
                ),
              ],
            )),
      ),
    );
  }
}
