import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_app/service/missing_dog_service.dart';
import 'package:flutter_mobile_app/view/widgets/detailPageWidgets/image_carousel.dart';

class MissingPetDetailImageCarouselSection extends StatefulWidget {
  const MissingPetDetailImageCarouselSection({super.key});

  @override
  State<MissingPetDetailImageCarouselSection> createState() =>
      _MissingPetDetailImageCarouselSectionState();
}

class _MissingPetDetailImageCarouselSectionState
    extends State<MissingPetDetailImageCarouselSection> {
  List<Image> _caruselImages = [];

  @override
  void initState() {
    getCaruselImages();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var element in _caruselImages) {
        precacheImage(element.image, context);
      }
    });
    super.initState();
  }

  void getCaruselImages() {
    var photos = context.read<MissingDogService>().missingPetDetail?.photos;
    if (photos != null) {
      _caruselImages = List<Image>.from(photos.map((e) {
        if (e.contains('http')) {
          return Image.network(
            e,
            fit: BoxFit.cover,
          );
        }
        return Image.file(
          File(e),
          fit: BoxFit.cover,
        );
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return _caruselImages.isNotEmpty
        ? Padding(
            padding:
                const EdgeInsets.only(bottom: 10, top: 20, left: 15, right: 15),
            child: ImageCarousel(
              images: _caruselImages,
            ),
          )
        : const SizedBox(
            height: 100,
          );
  }
}
