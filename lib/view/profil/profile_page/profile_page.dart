import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/view/profil/profile_page/profile_sections/profile_button_section.dart';
import 'package:flutter_mobile_app/view/profil/profile_page/profile_sections/profile_upper_section.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';
import '../../../service/edit_user_service.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EditUserService>().getUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomeScaffold(
      child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(
                  left: 15, top: 100, right: 15, bottom: 5),
              child: Column(
                children: [const ProfileUpperSection(), ProfileButtonSection()],
              ))),
    );
  }
}
