import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_form_page/missing_pet_form_sections/main_section.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/customeFormWidgets/search_list_form/search_list_form_field_widget.dart';

class ProfileEditFormSearchListField extends StatefulWidget {
  const ProfileEditFormSearchListField(
      {super.key,
      required this.formMainSectionController,
      required this.controllerValue});
  final FormMainSectionController formMainSectionController;
  final int? controllerValue;

  @override
  State<ProfileEditFormSearchListField> createState() =>
      _MissingPetFormSearchListFieldSection();
}

class _MissingPetFormSearchListFieldSection
    extends State<ProfileEditFormSearchListField> {
  final _breedController = TextEditingController();
  bool _expandController = false;
  final FocusNode _searchFocusNode = FocusNode();
  final List<String> _breedMock = [
    'Akita',
    'Akita amerykańska',
    'Basenji',
    'Beagle',
    'Cane corso',
    'Golden retriever',
    'Jack russell terrier',
  ];

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(focusHandler);
    var index = widget.controllerValue;
    if (index != null) {
      _breedController.text = _breedMock[index];
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.formMainSectionController.getBreedId = getBreedId;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _breedController.dispose();
    _searchFocusNode.dispose();
  }

  void expandHandler() {
    FocusManager.instance.primaryFocus?.unfocus();
    _searchFocusNode.requestFocus();
    setState(() {
      _expandController = true;
    });
  }

  void collapseField() {
    setState(() {
      _expandController = false;
    });
  }

  void focusHandler() {
    if (!_searchFocusNode.hasFocus) {
      _searchFocusNode.unfocus();
      collapseField();
    }
  }

  int getBreedId() {
    return _breedMock.indexOf(_breedController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SearchListFormField(
        itemsList: _breedMock,
        controller: _breedController,
        validator: (value) {
          if (value == null || value.text.isEmpty) {
            return 'Wypełnij pole';
          }
          return null;
        },
        minHeigh: 45,
        margin: const EdgeInsets.only(right: 1),
        expand: _expandController,
        expandHandlerFunction: expandHandler,
        focusNode: _searchFocusNode,
      ),
    );
  }
}
