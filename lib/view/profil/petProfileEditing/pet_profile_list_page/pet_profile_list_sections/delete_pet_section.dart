import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/buttonWidgets/delete_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/edit_dog_service.dart';
import 'package:flutter_mobile_app/view/widgets/popups/context_popups.dart';

class PetProfileListDeletePetSection extends StatelessWidget {
  PetProfileListDeletePetSection({super.key, required this.petId});
  final String petId;
  final ContextPopups _contextPopups = ContextPopups();

  void onDelete(BuildContext context, String id) {
    _contextPopups.decisionPopup(context, 'Czy napewno?').then((confirm) {
      if (confirm) {
        context.read<EditDogService>().deleteDog(id);
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: DeleteButton(
            elevation: 0,
            size: 20,
            iconSize: 15,
            padding: const EdgeInsets.all(0),
            onTap: () => onDelete(context, petId),
          )),
    );
  }
}
