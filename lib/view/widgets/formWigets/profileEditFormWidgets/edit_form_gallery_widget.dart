import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_mobile_app/view/missing/missing_pet_form_page/missing_pet_form_sections/main_section.dart';
import 'package:flutter_mobile_app/view/widgets/reordareable_image_wrap/reordareable_image_wrap.dart';

class ProfileEditFormGallery extends StatefulWidget {
  const ProfileEditFormGallery(
      {super.key, required this.formMainSectionController});
  final FormMainSectionController formMainSectionController;

  @override
  State<ProfileEditFormGallery> createState() =>
      _MissingPetFormMainGallerySectionState();
}

class _MissingPetFormMainGallerySectionState
    extends State<ProfileEditFormGallery> {
  final _controller = ScrollController();
  final ImagePicker _picker = ImagePicker();
  final List<Map<String, dynamic>> _images = [];
  final List<String> _imagesToDelete = [];

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.formMainSectionController.getImageMap = getImageMap;
    });
  }

  // uploadOrder() {
  //   List<String> orderList = [];
  //   for (var item in _images) {
  //     orderList.add(item['guid']);
  //   }
  //   _pictureService.reorderPictures(orderList);
  // }

  // void checkImageForRequest() async {
  //   if (_imagesToDelete.isNotEmpty) {
  //     _pictureService.deletePictures(_imagesToDelete);
  //   }
  //   if (_images.any((item) => !item['isSave'])) {
  //     await _pictureService.addPictures(_images).then((result) {
  //       for (var i = 0; i < result.length; i++) {
  //         var imageIndex = _images.indexWhere(
  //           (item) => item['guid'] == _images.length - (result.length - i),
  //         );
  //         _images[imageIndex]['guid'] = result[i];
  //         _images[imageIndex]['isSave'] = true;
  //       }
  //     });
  //   }
  //   uploadOrder();
  // }

  onReorder(int oldIndex, int newIndex) {
    setState(() {
      Map<String, dynamic> image = _images.removeAt(oldIndex);
      _images.insert(newIndex, image);
    });
  }

  getImageGallery() async {
    try {
      var imageFile = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 95);
      if (imageFile == null) return;
      setState(() {
        _images.add(
            {'guid': _images.length, 'value': imageFile.path, 'isSave': false});
      });
    } on PlatformException catch (_) {
      rethrow;
    }
  }

  deletingPhotos(Map<String, dynamic> image) {
    setState(() {
      _images.remove(image);
      if (image['isSave']) {
        _imagesToDelete.add(image['guid']);
      }
    });
  }

  Map<String, dynamic> getImageMap() {
    return {for (var element in _images) element['guid']: element['value']};
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: ReordareableImageWrapGrid(
              images: _images,
              getImageGallery: getImageGallery,
              onReorder: onReorder,
              onDelete: deletingPhotos,
              controller: _controller,
            )));
  }
}
