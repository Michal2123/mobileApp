import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/exercises_service.dart';
import 'package:flutter_mobile_app/view/widgets/search_bar_widget/search_bar_widget.dart';

class AllExercisesSearchSection extends StatefulWidget {
  const AllExercisesSearchSection({super.key});

  @override
  State<AllExercisesSearchSection> createState() =>
      _AllExercisesSearchSectionState();
}

class _AllExercisesSearchSectionState extends State<AllExercisesSearchSection> {
  final TextEditingController _searchBarTextController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchBarTextController.addListener(searchFor);
  }

  @override
  void dispose() {
    super.dispose();
    _searchBarTextController.dispose();
  }

  void searchFor() {
    if (_searchBarTextController.text.isEmpty) {
      context.read<ExercisesService>().resetExercisesList();
      return;
    }
    context.read<ExercisesService>().search(_searchBarTextController.text);
  }

  void clearSearch() {
    context.read<ExercisesService>().resetExercisesList();
    _searchBarTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return CustomeSearchBar(
      searchBarTextController: _searchBarTextController,
      clearController: () => clearSearch(),
    );
  }
}
