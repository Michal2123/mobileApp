import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/model/swipe_models/swipe_profile_model.dart';
import 'package:flutter_mobile_app/view/swipe/detail_profile_page/detail_profile_sections/main_base_info_section.dart';
import 'package:flutter_mobile_app/view/swipe/detail_profile_page/detail_profile_sections/main_extend_info_section.dart';
import 'package:flutter_mobile_app/view/swipe/detail_profile_page/detail_profile_sections/pet_details_section.dart';
import 'package:flutter_mobile_app/view/widgets/detailPageWidgets/image_carousel.dart';

class DetailProfileMainSection extends StatefulWidget {
  const DetailProfileMainSection({super.key, required this.swipeProfileModel});
  final SwipeProfileModel swipeProfileModel;

  @override
  State<DetailProfileMainSection> createState() =>
      _DetailProfileMainSectionState();
}

class _DetailProfileMainSectionState extends State<DetailProfileMainSection> {
  List<Image> _caruselImages = [];

  @override
  void initState() {
    getCaruselImages();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    for (var caruselImage in _caruselImages) {
      precacheImage(caruselImage.image, context);
    }
    super.didChangeDependencies();
  }

  void getCaruselImages() {
    var photos = widget.swipeProfileModel.photos;
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
    return ListView(
      padding: const EdgeInsets.only(bottom: 90),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: ImageCarousel(
            images: _caruselImages,
          ),
        ),
        DetailProfileMainBaseInfoSection(
          firstName: widget.swipeProfileModel.firstName,
          distance: widget.swipeProfileModel.distance,
        ),
        DetailProfileMainExtendInfoSection(
          description: widget.swipeProfileModel.description,
          tags: widget.swipeProfileModel.tags,
        ),
        Column(
            children: widget.swipeProfileModel.dogs
                    ?.map((pet) => DetailProfilePetDetailsSection(
                        swipeProfileDogModel: pet))
                    .toList() ??
                [])
      ],
    );
  }
}
