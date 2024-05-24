import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/model/swipe_models/swipe_profile_model.dart';
import 'package:flutter_mobile_app/service/swipe_profile_service.dart';
import 'package:flutter_mobile_app/view/swipe/swipe_page/swipe_page.dart';
import 'package:flutter_mobile_app/view/widgets/popups/context_popups.dart';
import 'package:flutter_mobile_app/view/widgets/swipeWidgets/swipe_item.dart';

class SwipeMainCardSection extends StatefulWidget {
  const SwipeMainCardSection({super.key, required this.swipeMainController});
  final SwipeController swipeMainController;
  @override
  State<SwipeMainCardSection> createState() => _SState();
}

class _SState extends State<SwipeMainCardSection> {
  final AppinioSwiperController _controller = AppinioSwiperController();
  List<SwipeItem> _swipeProfiles = [];

  @override
  void initState() {
    super.initState();
    widget.swipeMainController.swipeLeft = _controller.swipeLeft;
    widget.swipeMainController.swipeRight = _controller.swipeRight;
  }

  List<SwipeItem> swipeListGenerate(List<SwipeProfileModel> swipeProfiles) {
    return List<SwipeItem>.generate(
        swipeProfiles.length,
        (index) => SwipeItem(
            swipeProfileModel: swipeProfiles[index],
            swipeController: widget.swipeMainController));
  }

  Future<void> matchCheck(int index, SwiperActivity activity) async {
    if (activity.direction == AxisDirection.right) {
      context
          .read<SwipeProfileService>()
          .acceptProfile(_swipeProfiles[index].id)
          .then((isAccept) {
        if (isAccept) {
          ContextPopups().swipeAcceptPopup(
              context,
              _swipeProfiles[index].firstName,
              _swipeProfiles[index].photos.isNotEmpty
                  ? _swipeProfiles[index].photos.first
                  : '');
        }
      });
    }
  }

  void _swipe(int prevIndex, int targetIndex, SwiperActivity activity) {
    matchCheck(targetIndex, activity).then((_) {
      context
          .read<SwipeProfileService>()
          .deleteProfile()
          .then((_) => context.read<SwipeProfileService>().getProfiles(20));
    });
  }

  @override
  Widget build(BuildContext context) {
    var profilesFromService =
        context.watch<SwipeProfileService>().swipeProfiles;
    _swipeProfiles = swipeListGenerate(profilesFromService);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const FlutterLogo(
              size: 150,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .75,
              child: _swipeProfiles.isNotEmpty
                  ? AppinioSwiper(
                      controller: _controller,
                      onSwipeEnd: _swipe,
                      backgroundCardCount: 2,
                      swipeOptions: const SwipeOptions.symmetric(
                          horizontal: true, vertical: false),
                      cardCount: _swipeProfiles.length,
                      cardBuilder: (context, index) =>
                          _swipeProfiles[index].buildSwipe(context),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
