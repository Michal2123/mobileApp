import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/helper/cache_image_manager.dart';
import 'package:flutter_mobile_app/main.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/mapWidgets/map_form_widget.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/button.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class ContextPopups {
  mapPopup(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const MapForm();
        });
  }

  Future<dynamic> alertPopup(BuildContext context, String tytleMessage) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: InputLabelText(
              fontSize: 14,
              maxLines: 5,
              text: tytleMessage,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: const EdgeInsets.only(bottom: 25),
            backgroundColor: ColorConstant.backgroundScaffoldColor,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'ok',
                      style: ButtonTextStyle(),
                    )),
              ),
            ],
          );
        });
  }

  loadingIndicator(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: Center(
                child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      color: ColorConstant.inkWellTextColor,
                    )),
              ),
            ));
  }

  swipeAcceptPopup(
      BuildContext context, String newFriendName, String newFriendPhotoUrl) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Align(
              alignment: Alignment.center,
              child: newFriendPhotoUrl.isEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: const FlutterLogo(size: 150),
                    )
                  : CachedNetworkImage(
                      imageUrl: newFriendPhotoUrl,
                      fit: BoxFit.cover,
                      height: 150,
                      width: 150,
                      cacheManager: CacheImageManager.instance,
                      placeholder: (context, url) => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
            ),
            content: InputLabelText(
              fontSize: 14,
              maxLines: 2,
              text: 'Ty i $newFriendName jesteście teraz znajomymi!',
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: const EdgeInsets.only(bottom: 25),
            backgroundColor: ColorConstant.backgroundScaffoldColor,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'ok',
                      style: ButtonTextStyle(),
                    )),
              ),
            ],
          );
        });
  }

  Future<bool> decisionPopup(BuildContext context, String titleMessage) async {
    bool confirm = false;
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Align(
                alignment: Alignment.center,
                child: InputLabelText(
                  maxLines: 2,
                  text: titleMessage,
                )),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: const EdgeInsets.only(bottom: 25),
            backgroundColor: ColorConstant.backgroundScaffoldColor,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ElevatedButton(
                    onPressed: () {
                      confirm = true;
                      Navigator.pop(navigatorKey.currentContext!);
                    },
                    child: Text(
                      'tak',
                      style: ButtonTextStyle(),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ElevatedButton(
                    onPressed: () {
                      confirm = false;
                      Navigator.pop(navigatorKey.currentContext!);
                    },
                    child: Text(
                      'nie',
                      style: ButtonTextStyle(),
                    )),
              ),
            ],
          );
        });
    return confirm;
  }
}
