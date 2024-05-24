import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/login_service.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_room_service.dart';
import 'package:flutter_mobile_app/service/swipe_profile_service.dart';
import 'package:flutter_mobile_app/view/login/login_page/login_sections/bottom_list_section.dart';
import 'package:flutter_mobile_app/view/login/login_page/login_sections/form_section.dart';
import 'package:flutter_mobile_app/view/swipe/swipe_page/swipe_page.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/sign_button_section.dart';
import 'package:flutter_mobile_app/view/widgets/sign_widgets/form_top_section.dart';

class LoginMainSection extends StatefulWidget {
  const LoginMainSection({super.key});

  @override
  State<LoginMainSection> createState() => _LoginMainSectionState();
}

class _LoginMainSectionState extends State<LoginMainSection> {
  final _loginService = LoginService();
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _controllers = {};

  bool _isLoading = false;

  void saveControllersData(Map<String, dynamic> data) {
    _controllers.addAll(data);
  }

  void loading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void onSubmit() {
    if (_formKey.currentState!.validate() && !_isLoading) {
      _formKey.currentState!.save();
      loading();
      _loginService
          .login(
        _controllers['email'],
        _controllers['password'],
      )
          .then((_) {
        context.read<MessangerConnectionService>().openChatConnection().then(
            (value) => Future.wait([
                  context.read<MessangerRoomService>().joinRooms(),
                  context.read<SwipeProfileService>().getProfiles(20),
                ]).then(
                    (_) => context.read<MessangerRoomService>().getFriends()));

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Swipe()));
      }).onError((error, stackTrace) {
        loading();
        return null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SignFormTopSection(
          tytle: "Witaj z powrotem!",
        ),
        LoginFormSection(
          formKey: _formKey,
          saveControllersData: saveControllersData,
        ),
        SignFormButtonSection(
          tytle: 'Zaloguj się',
          submit: onSubmit,
          isLoading: _isLoading,
        ),
        const LoginBottomListSection(),
      ],
    );
  }
}
