import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/scaffold_service.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_bottom_navigation_bar_widget.dart';
import 'package:flutter_mobile_app/view/widgets/customeScaffoldWidgets/custome_drawer/custome_drawer_widget.dart';
import 'package:flutter_mobile_app/view/widgets/screen_positioning_widget.dart';

class CustomeScaffold extends StatelessWidget {
  const CustomeScaffold(
      {super.key,
      this.unfocusFunction,
      required this.child,
      this.showBottomNavigationBar = true,
      this.appbar,
      this.floatingActionButton,
      this.floatingActionButtonLocation});
  final Widget child;
  final Function()? unfocusFunction;
  final bool showBottomNavigationBar;
  final PreferredSizeWidget? appbar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      appBar: appbar,
      drawer: const CustomeDrawer(),
      onDrawerChanged: (isOpened) =>
          context.read<ScaffoldService>().onDrawerChange(isOpened),
      drawerScrimColor: Colors.black26,
      body: GestureDetector(
        onTap: unfocusFunction,
        child: SafeArea(
          child: ScreenMaxWitdhRatio(
            child: child,
          ),
        ),
      ),
      bottomNavigationBar:
          showBottomNavigationBar ? const CustomeBottomNavBar() : null,
    );
  }
}
