import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/model/announcment_service_model.dart';
import 'package:flutter_mobile_app/view/announcment_service/announcment_sections/list_section.dart';
import 'package:flutter_mobile_app/view/announcment_service/announcment_sections/search_section.dart';
import 'package:flutter_mobile_app/view/announcment_service/announcment_sections/top_bar_section.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_scaffold_widget.dart';

enum AnnouncmentEnum { type0, type1, type2, type3 }

class AnnouncmentService extends StatefulWidget {
  const AnnouncmentService({super.key});

  @override
  State<AnnouncmentService> createState() => _AnnouncmentServiceState();
}

class _AnnouncmentServiceState extends State<AnnouncmentService> {
  final TextEditingController _searchBarTextController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _filtersViewList =
      List<Map<String, dynamic>>.generate(
          AnnouncmentEnum.values.length,
          (index) => {
                'title': AnnouncmentEnum.values[index].name,
                'isChacked': false
              });
  final List<int> _filtersList = [];
  final List<AnnouncmentServiceModel> _announcmentServiceMockList = [
    const AnnouncmentServiceModel(
        id: '0',
        title: 'Service#1',
        describe: 'describe',
        adress: 'mock.st',
        score: 4.2,
        type: 0),
    const AnnouncmentServiceModel(
        id: '1',
        title: 'Service#2',
        describe: 'describe',
        adress: 'mock.st',
        score: 4.7,
        type: 1),
    const AnnouncmentServiceModel(
        id: '2',
        title: 'Service#3',
        describe: 'describe',
        adress: 'mock.st',
        score: 4.1,
        type: 2),
    const AnnouncmentServiceModel(
        id: '3',
        title: 'Service#4',
        describe: 'describe',
        adress: 'mock.st',
        score: 2.1,
        type: 3),
    const AnnouncmentServiceModel(
        id: '4',
        title: 'Service#5',
        describe: 'describe',
        adress: 'mock.st',
        score: 5,
        type: 2),
  ];

  List<AnnouncmentServiceModel> _announcmentListToShow = [];

  @override
  void initState() {
    _searchBarTextController.addListener(searchFor);
    _announcmentListToShow = _announcmentServiceMockList.toList();
    super.initState();
  }

  @override
  void dispose() {
    _searchBarTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void searchFor() {
    setState(() {
      if (_searchBarTextController.text.isEmpty) {
        _announcmentListToShow = _announcmentServiceMockList.toList();
        return;
      }
      _announcmentListToShow = _announcmentServiceMockList
          .where((element) => element.title
              .toLowerCase()
              .contains(_searchBarTextController.text.toLowerCase()))
          .toList();
    });
  }

  void filterSubmit(List<Map<String, dynamic>> filtersViewList) {
    for (var i = 0; i < filtersViewList.length; i++) {
      if (filtersViewList[i]['isChacked']) {
        if (!_filtersList.contains(i)) {
          _filtersList.add(i);
        }
        continue;
      }
      _filtersList.removeWhere((element) => element == i);
    }
    searchFor();
  }

  @override
  Widget build(BuildContext context) {
    return CustomeScaffold(
      unfocusFunction: FocusManager.instance.primaryFocus!.unfocus,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            AnnouncmentTopBarSection(scrollController: _scrollController),
            AnnouncmentSearchSection(
              announcmentServiceMockList: _announcmentServiceMockList,
              filtersViewList: _filtersViewList,
              searchBarTextController: _searchBarTextController,
              searchFunction: searchFor,
              filterFunction: filterSubmit,
            ),
            AnnouncmentListSection(
              announcmentListToShow: _announcmentListToShow,
              filtersList: _filtersList,
              scrollController: _scrollController,
            ),
          ],
        ),
      ),
    );
  }
}
