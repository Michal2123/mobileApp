import 'package:flutter_mobile_app/repository/account_settings_repository.dart';

class AccountSettingsService {
  final _accountSettingsRepository = AccountSettingsRepository();
  Future<void> passwordReset(String email) async {
    await _accountSettingsRepository.passwordReset(email);
  }

  Future<void> passwordChange(
      String currentPassword, String newPassword) async {
    await _accountSettingsRepository.passwordChange(
        currentPassword, newPassword);
  }

  Future<void> emailChange(String email) async {
    await _accountSettingsRepository.emailChange(email);
  }
}
