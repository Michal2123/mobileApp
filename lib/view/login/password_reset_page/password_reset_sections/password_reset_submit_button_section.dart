import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/service/account_settings_service.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/popups/context_popups.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/button.dart';

class PasswordResetSubmitButtonSection extends StatefulWidget {
  const PasswordResetSubmitButtonSection(
      {super.key, required this.formKey, required this.emailController});
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;

  @override
  State<PasswordResetSubmitButtonSection> createState() =>
      _PasswordResetSubmitButtonSectionState();
}

class _PasswordResetSubmitButtonSectionState
    extends State<PasswordResetSubmitButtonSection> {
  final AccountSettingsService _accountSettingsService =
      AccountSettingsService();
  final ContextPopups _contextPopups = ContextPopups();

  bool _isLoading = false;

  void onSubmit() {
    if (widget.formKey.currentState!.validate() && !_isLoading) {
      setState(() {
        _isLoading = !_isLoading;
      });
      _accountSettingsService
          .passwordReset(widget.emailController.text)
          .then((_) {
        setState(() {
          _isLoading = !_isLoading;
        });
        _contextPopups.alertPopup(context,
            'Na podany adres Email zostanie wysłana wiadomość z linkiem resetującym hasło.');
      }).onError((error, stackTrace) {
        setState(() {
          _isLoading = !_isLoading;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
          padding: const EdgeInsets.all(15),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(150, 60),
              ),
              onPressed: () => onSubmit(),
              child: _isLoading
                  ? SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: ColorConstant.buttonTextColor,
                      ),
                    )
                  : Text(
                      'Resetuj hasło',
                      style: ButtonTextStyle(),
                    ))),
    );
  }
}
