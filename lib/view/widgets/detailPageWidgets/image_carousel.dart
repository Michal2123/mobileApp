import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/view/widgets/screen_positioning_widget.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key, required this.images});
  final List<Image> images;
  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final CarouselController _controller = CarouselController();
  int _galleryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return widget.images.isNotEmpty
        ? Stack(children: [
            CarouselSlider(
                options: CarouselOptions(
                  enableInfiniteScroll: widget.images.length > 1,
                  viewportFraction: 1,
                  height: ScreenMaxWitdhRatio.heightResize(context, 0.65),
                  autoPlay: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _galleryIndex = index;
                    });
                  },
                ),
                carouselController: _controller,
                items: widget.images),
            SizedBox(
              height: ScreenMaxWitdhRatio.heightResize(context, 0.65),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < widget.images.length; i++)
                        GestureDetector(
                          onTap: () {
                            _controller.animateToPage(i);
                            setState(() {
                              _galleryIndex = i;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2.5),
                            child: Text(
                              '.',
                              style: TextStyle(
                                  fontSize: 50,
                                  color: _galleryIndex == i
                                      ? Colors.white
                                      : Colors.white38,
                                  fontFamily: 'Nunito'),
                            ),
                          ),
                        )
                    ]),
              ),
            )
          ])
        : const SizedBox(
            height: 50,
          );
  }
}
