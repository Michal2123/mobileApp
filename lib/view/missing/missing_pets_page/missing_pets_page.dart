import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/missing_dog_service.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:flutter_mobile_app/view/missing/missing_pets_page/missing_pets_sections/announcement_list_section.dart';
import 'package:flutter_mobile_app/view/missing/missing_pets_page/missing_pets_sections/upper_section.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';

class MissingPetsController {
  late Function(MissingPageTabs) getToggleValue;
}

class MissingPets extends StatefulWidget {
  const MissingPets({super.key});

  @override
  State<MissingPets> createState() => _MissingPetsState();
}

class _MissingPetsState extends State<MissingPets> {
  final ScrollController _scrollController = ScrollController();
  final MissingPetsController _missingPetsController = MissingPetsController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MissingDogService>().getAllCurrentAds();
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void toggleTab(MissingPageTabs tab) {
    _missingPetsController.getToggleValue(tab);
  }

  @override
  Widget build(BuildContext context) {
    return CustomeScaffold(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            MissingPetsUpperSection(
              scrollController: _scrollController,
              toggleTab: toggleTab,
            ),
            Expanded(
              child: MissingPetsAnnouncementListSection(
                scrollController: _scrollController,
                missingPetsController: _missingPetsController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
