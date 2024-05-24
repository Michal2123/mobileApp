import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/model/edit_profile_models/edit_user_model.dart';
import 'package:flutter_mobile_app/service/map_service.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/customeFormWidgets/localization_picker_form/localization_picker_form_field_widget.dart';
import 'package:flutter_mobile_app/view/widgets/popups/context_popups.dart';

class ProfileEditFormLocalizationfield extends StatefulWidget {
  const ProfileEditFormLocalizationfield(
      {super.key,
      required this.validator,
      required this.coordinates,
      required this.title});
  final String? Function(TextEditingValue?) validator;
  final Coordinates? coordinates;
  final String title;

  @override
  State<ProfileEditFormLocalizationfield> createState() =>
      _MissingPetFormLocalizationFieldSectionState();
}

class _MissingPetFormLocalizationFieldSectionState
    extends State<ProfileEditFormLocalizationfield> {
  final TextEditingController _controller = TextEditingController();
  final ContextPopups _contextPopups = ContextPopups();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void expandHandler() {
    _contextPopups.mapPopup(context);
  }

  @override
  Widget build(BuildContext context) {
    var latLng = context.watch<MapService>().latLng;
    if (latLng != null && latLng.latitude != 0 && latLng.longitude != 0) {
      _controller.text =
          'x:${latLng.longitude.toString().substring(0, 10)} y:${latLng.latitude.toString().substring(0, 10)}';
    }
    return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: LocalizationPickerFormField(
          title: widget.title,
          minHeigh: 45,
          margin: const EdgeInsets.only(right: 1),
          expandHandlerFunction: expandHandler,
          controller: _controller,
          validator: widget.validator,
        ));
  }
}
