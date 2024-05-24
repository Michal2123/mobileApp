import 'dart:async';
import '../repository/registration_repository.dart';

class RegistrationService {
  final _registrationRepository = RegistrationRepository();

  Future<dynamic> register(
      String email, String password, String username) async {
    return _registrationRepository.register(email, password, username);
  }
}
