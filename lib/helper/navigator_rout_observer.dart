import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/utils/enums.dart';

class NavigatorRoutObserver extends NavigatorObserver {
  MainPages _page = MainPages.swipePage;
  MainPages get page => _page;

  @override
  void didPop(Route route, Route? previousRoute) {
    if (previousRoute != null) {
      var previousRouteName = MainPages.values.firstWhere(
          (element) => element.name == previousRoute.settings.name,
          orElse: () => MainPages.swipePage);
      switch (previousRouteName) {
        case MainPages.announcmentPage:
          _page = MainPages.announcmentPage;
          break;
        case MainPages.excercisePage:
          _page = MainPages.excercisePage;
          break;
        case MainPages.messangerPage:
          _page = MainPages.messangerPage;
          break;
        case MainPages.missingPage:
          _page = MainPages.missingPage;
          break;
        case MainPages.profilePage:
          _page = MainPages.profilePage;
          break;
        case MainPages.swipePage:
          _page = MainPages.swipePage;
          break;
        default:
      }
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    var routeName = MainPages.values.firstWhere(
      (element) => element.name == route.settings.name,
      orElse: () => MainPages.swipePage,
    );
    switch (routeName) {
      case MainPages.announcmentPage:
        _page = MainPages.announcmentPage;
        break;
      case MainPages.excercisePage:
        _page = MainPages.excercisePage;
        break;
      case MainPages.messangerPage:
        _page = MainPages.messangerPage;
        break;
      case MainPages.missingPage:
        _page = MainPages.missingPage;
        break;
      case MainPages.profilePage:
        _page = MainPages.profilePage;
        break;
      case MainPages.swipePage:
        _page = MainPages.swipePage;
        break;
      default:
    }
  }
}
