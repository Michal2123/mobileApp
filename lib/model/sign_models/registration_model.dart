class RegistrationModel {
  final String email;
  final String password;
  final String username;

  RegistrationModel(
      {required this.email, required this.password, required this.username});

  Map toJson() => {
        'email': email,
        'password': password,
        'userName': username,
      };
}
