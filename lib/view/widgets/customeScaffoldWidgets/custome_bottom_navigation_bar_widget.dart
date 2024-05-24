import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/helper/navigator_rout_observer.dart';
import 'package:flutter_mobile_app/service/exercises_service.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_room_service.dart';
import 'package:flutter_mobile_app/service/scaffold_service.dart';
import 'package:flutter_mobile_app/service/swipe_profile_service.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:flutter_mobile_app/view/exercises/all_exercises_page/all_exercises_page.dart';
import 'package:flutter_mobile_app/view/messanger/messanger_page/messanger_page.dart';
import 'package:flutter_mobile_app/view/swipe/swipe_page/swipe_page.dart';

import '../../profil/profile_page/profile_page.dart';

class CustomeBottomNavBar extends StatefulWidget {
  const CustomeBottomNavBar({super.key});

  @override
  State<CustomeBottomNavBar> createState() => _CustomeBottomNavBarState();
}

class _CustomeBottomNavBarState extends State<CustomeBottomNavBar> {
  final _observer = KiwiContainer().resolve<NavigatorRoutObserver>();
  late MainPages _currentPage;

  @override
  void initState() {
    _currentPage = _observer.page;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      color: ColorConstant.backgroundScaffoldColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Icon(Icons.menu,
                size: 40,
                color: context.watch<ScaffoldService>().isDrawerOpen
                    ? ColorConstant.activeButton
                    : null),
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          GestureDetector(
            child: Icon(Icons.pets_rounded,
                size: 40,
                color: _currentPage == MainPages.excercisePage &&
                        !context.watch<ScaffoldService>().isDrawerOpen
                    ? ColorConstant.activeButton
                    : null),
            onTap: () {
              if (_currentPage != MainPages.excercisePage) {
                context.read<ExercisesService>().getExercises();
                Navigator.of(context).push(MaterialPageRoute(
                  settings: RouteSettings(name: MainPages.excercisePage.name),
                  builder: (context) => const AllExercises(),
                ));
              }
            },
          ),
          GestureDetector(
            child: Icon(Icons.home_rounded,
                size: 40,
                color: _currentPage == MainPages.swipePage &&
                        !context.watch<ScaffoldService>().isDrawerOpen
                    ? ColorConstant.activeButton
                    : null),
            onTap: () {
              if (_currentPage != MainPages.swipePage) {
                context.read<SwipeProfileService>().getProfiles(20);
                Navigator.of(context).push(MaterialPageRoute(
                  settings: RouteSettings(name: MainPages.swipePage.name),
                  builder: (context) => Swipe(),
                ));
              }
            },
          ),
          GestureDetector(
            child: Icon(Icons.message_rounded,
                size: 40,
                color: _currentPage == MainPages.messangerPage &&
                        !context.watch<ScaffoldService>().isDrawerOpen
                    ? ColorConstant.activeButton
                    : null),
            onTap: () {
              if (_currentPage != MainPages.messangerPage) {
                context
                    .read<MessangerRoomService>()
                    .joinRooms()
                    .then((_) =>
                        context.read<MessangerRoomService>().getFriends())
                    .then((_) => Navigator.of(context).push(MaterialPageRoute(
                        settings:
                            RouteSettings(name: MainPages.messangerPage.name),
                        builder: (context) => const Messanger())));
              }
            },
          ),
          GestureDetector(
            child: Icon(Icons.person,
                size: 40,
                color: _currentPage == MainPages.profilePage &&
                        !context.watch<ScaffoldService>().isDrawerOpen
                    ? ColorConstant.activeButton
                    : null),
            onTap: () {
              if (_currentPage != MainPages.profilePage) {
                Navigator.of(context).push(MaterialPageRoute(
                    settings: RouteSettings(name: MainPages.profilePage.name),
                    builder: (context) => const Profile()));
              }
            },
          ),
        ],
      ),
    );
  }
}
