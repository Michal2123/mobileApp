import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/profile_edit_form_button.dart';

class ProfileEditFormUpperSection extends StatelessWidget {
  const ProfileEditFormUpperSection(
      {super.key, required this.onPreview, required this.onSubmit});
  final Function() onPreview;
  final Function() onSubmit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 25.0, bottom: 30, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ProfileEditFormButton(
            title: 'Podgląd',
            onTap: () => onPreview(),
          ),
          ProfileEditFormButton(
            title: 'Gotowe',
            onTap: () => onSubmit(),
          ),
        ],
      ),
    );
  }
}
