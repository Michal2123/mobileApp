import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_form_page/missing_pet_form_sections/main_section.dart';
import 'package:flutter_mobile_app/view/widgets/formWigets/customeFormWidgets/tag_picker_form/tag_picker_form_field_widget.dart';

class ProfileEditFormTagField extends StatefulWidget {
  const ProfileEditFormTagField(
      {super.key, required this.formMainSectionController, this.userTags});
  final FormMainSectionController formMainSectionController;
  final List<String>? userTags;

  @override
  State<ProfileEditFormTagField> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProfileEditFormTagField> {
  final FocusNode _node = FocusNode();
  late List<String> _tags = [];
  final List<String> _tagsMock = [
    'herbata',
    'stopy',
    'pazury',
    'żaby',
    'moniaki',
    'miedziaki',
  ];

  bool tagsExpand = false;

  @override
  void initState() {
    super.initState();
    _tags = List<String>.from(widget.userTags ?? []);
    _node.addListener(colapseField);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.formMainSectionController.getTags = getTags;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _node.dispose();
  }

  void tagHandler(String tag) {
    setState(() {
      if (_tags.contains(tag)) {
        _tags.removeWhere((element) => element == tag);
        return;
      }
      _tags.add(tag);
    });
  }

  void expandList() {
    FocusScope.of(context).requestFocus(_node);
    setState(() {
      tagsExpand = true;
    });
  }

  void colapseField() {
    if (_node.hasFocus == false) {
      setState(() {
        tagsExpand = false;
      });
    }
  }

  List<String> getTags() {
    return _tags;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: TagPickerFormField(
        minHeigh: 55,
        margin: const EdgeInsets.only(top: 16, right: 1),
        expand: tagsExpand,
        expandHandlerFunction: expandList,
        tagHandlerFunction: tagHandler,
        title: 'Dodaj tag',
        tagList: _tagsMock,
        selectTagList: _tags,
      ),
    );
  }
}
