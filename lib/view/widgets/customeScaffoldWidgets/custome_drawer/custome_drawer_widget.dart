import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';
import 'package:kiwi/kiwi.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/helper/navigator_rout_observer.dart';
import 'package:flutter_mobile_app/service/exercises_service.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_room_service.dart';
import 'package:flutter_mobile_app/service/swipe_profile_service.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:flutter_mobile_app/view/announcment_service/announcment_service_page.dart';
import 'package:flutter_mobile_app/view/exercises/all_exercises_page/all_exercises_page.dart';
import 'package:flutter_mobile_app/view/messanger/messanger_page/messanger_page.dart';
import 'package:flutter_mobile_app/view/missing/missing_pets_page/missing_pets_page.dart';
import 'package:flutter_mobile_app/view/profil/profile_page/profile_page.dart';
import 'package:flutter_mobile_app/view/swipe/swipe_page/swipe_page.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_drawer/custome_drawer_item_widget.dart';
import 'package:flutter_mobile_app/view/widgets/screen_positioning_widget.dart';

class CustomeDrawer extends StatefulWidget {
  const CustomeDrawer({super.key});

  @override
  State<CustomeDrawer> createState() => _CustomeDrawerState();
}

class _CustomeDrawerState extends State<CustomeDrawer> {
  final _observer = KiwiContainer().resolve<NavigatorRoutObserver>();
  late MainPages _currentPage;

  @override
  void initState() {
    _currentPage = _observer.page;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        height: MediaQuery.of(context).size.height - 75,
        width: ScreenMaxWitdhRatio.maxWidth,
        color: ColorConstant.backgroundScaffoldColor,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 75),
              child: Align(
                  alignment: Alignment.center,
                  child: InputLabelText(
                    fontSize: 30,
                    text: 'menu',
                  )),
            ),
            Expanded(
                child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.25, crossAxisCount: 2),
              children: [
                CustomeDrawerItem(
                  title: 'Zaginione',
                  icon: Icons.search_rounded,
                  titleColor: _currentPage == MainPages.missingPage
                      ? ColorConstant.activeButton
                      : null,
                  onTap: () {
                    if (_currentPage != MainPages.missingPage) {
                      Scaffold.of(context).closeDrawer();
                      Navigator.of(context).push(MaterialPageRoute(
                        settings:
                            RouteSettings(name: MainPages.missingPage.name),
                        builder: (context) => const MissingPets(),
                      ));
                    }
                  },
                ),
                CustomeDrawerItem(
                  title: 'Usługi',
                  icon: Icons.announcement_rounded,
                  titleColor: _currentPage == MainPages.announcmentPage
                      ? ColorConstant.activeButton
                      : null,
                  onTap: () {
                    if (_currentPage != MainPages.announcmentPage) {
                      Scaffold.of(context).closeDrawer();
                      Navigator.of(context).push(MaterialPageRoute(
                        settings:
                            RouteSettings(name: MainPages.announcmentPage.name),
                        builder: (context) => const AnnouncmentService(),
                      ));
                    }
                  },
                ),
                CustomeDrawerItem(
                  title: 'Trening',
                  icon: Icons.pets_rounded,
                  titleColor: _currentPage == MainPages.excercisePage
                      ? ColorConstant.activeButton
                      : null,
                  onTap: () {
                    if (_currentPage != MainPages.excercisePage) {
                      context.read<ExercisesService>().getExercises();
                      Scaffold.of(context).closeDrawer();
                      Navigator.of(context).push(MaterialPageRoute(
                        settings:
                            RouteSettings(name: MainPages.excercisePage.name),
                        builder: (context) => const AllExercises(),
                      ));
                    }
                  },
                ),
                CustomeDrawerItem(
                    title: 'Pieski',
                    icon: Icons.home_rounded,
                    titleColor: _currentPage == MainPages.swipePage
                        ? ColorConstant.activeButton
                        : null,
                    onTap: () {
                      if (_currentPage != MainPages.swipePage) {
                        context.read<SwipeProfileService>().getProfiles(20);
                        Scaffold.of(context).closeDrawer();
                        Navigator.of(context).push(MaterialPageRoute(
                          settings:
                              RouteSettings(name: MainPages.swipePage.name),
                          builder: (context) => Swipe(),
                        ));
                      }
                    }),
                CustomeDrawerItem(
                    title: 'Powiadomienia',
                    icon: Icons.message_rounded,
                    titleColor: _currentPage == MainPages.messangerPage
                        ? ColorConstant.activeButton
                        : null,
                    onTap: () {
                      if (_currentPage != MainPages.messangerPage) {
                        Scaffold.of(context).closeDrawer();
                        context
                            .read<MessangerRoomService>()
                            .joinRooms()
                            .then((_) => context
                                .read<MessangerRoomService>()
                                .getFriends())
                            .then((_) {
                          Navigator.of(context).push(MaterialPageRoute(
                            settings: RouteSettings(
                                name: MainPages.messangerPage.name),
                            builder: (context) => const Messanger(),
                          ));
                        });
                      }
                    }),
                CustomeDrawerItem(
                    title: 'Konto',
                    icon: Icons.person,
                    titleColor: _currentPage == MainPages.profilePage
                        ? ColorConstant.activeButton
                        : null,
                    onTap: () {
                      if (_currentPage != MainPages.profilePage) {
                        Scaffold.of(context).closeDrawer();
                        Navigator.of(context).push(MaterialPageRoute(
                          settings:
                              RouteSettings(name: MainPages.profilePage.name),
                          builder: (context) => const Profile(),
                        ));
                      }
                    }),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
