import 'package:flutter/foundation.dart';
import 'package:flutter_mobile_app/model/exercise_models/exercise_detail_model.dart';
import 'package:flutter_mobile_app/model/exercise_models/exercise_model.dart';
import 'package:flutter_mobile_app/repository/exercises_repository.dart';

class ExercisesService with ChangeNotifier, DiagnosticableTreeMixin {
  List<ExerciseModel> exercisesList = [];
  static const String exercisesListPropName = "exercisesList";

  List<CategoryModel> _categoryList = [];
  List<CategoryModel> get categoryList => _categoryList;
  static const String categoryListPropName = "categoryList";

  ExerciseDetailModel? _exerciseDetail;
  ExerciseDetailModel? get exerciseDetail => _exerciseDetail;
  static const String exerciseDetailPropName = "exerciseDetail";

  List<ExerciseModel> _baseList = [];
  final _exercisesRepository = ExercisesRepository();

  Future<void> getExercises() async {
    var response = await _exercisesRepository.getExercises();
    _baseList = ExerciseModel.getListFromJson(response);
    exercisesList = _baseList.toList();
    getCategoryList();
    notifyListeners();
  }

  void getCategoryList() {
    _categoryList = exercisesList.map((e) => e.category).toList();
    final ids = exercisesList.map((e) => e.category.key).toSet();
    _categoryList.retainWhere((element) => ids.remove(element.key));
    _categoryList = _categoryList.reversed.toList();
  }

  void resetExercisesList() {
    exercisesList = _baseList.toList();
    notifyListeners();
  }

  void search(String phrase) {
    exercisesList = _baseList
        .where((exercise) =>
            exercise.title.toLowerCase().contains(phrase.toLowerCase()))
        .toList();
    getCategoryList();
    notifyListeners();
  }

  Future<void> getExerciseDetail(String exerciseId) async {
    var response = await _exercisesRepository.getDetails(exerciseId);
    _exerciseDetail = ExerciseDetailModel.fromJson(response);
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('exercisesList', exercisesList));
    properties.add(IterableProperty('categoryList', categoryList));
  }
}
