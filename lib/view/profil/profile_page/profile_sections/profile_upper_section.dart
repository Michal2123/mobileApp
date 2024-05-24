import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/edit_user_service.dart';
import 'package:flutter_mobile_app/view/widgets/detailPageWidgets/profile_image.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class ProfileUpperSection extends StatelessWidget {
  const ProfileUpperSection({super.key});

  @override
  Widget build(BuildContext context) {
    var imagePath = context
        .watch<EditUserService>()
        .editUserModel
        ?.photos
        ?.values
        .first as String?;
    var firstName = context.watch<EditUserService>().editUserModel?.firstName;
    return Column(
      children: [
        ProfileImage(
          imagePath: imagePath,
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: InputLabelText(text: firstName ?? ''),
          ),
        )
      ],
    );
  }
}
