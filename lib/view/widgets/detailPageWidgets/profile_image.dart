import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/helper/cache_image_manager.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/view/widgets/text_style/text_style_widgets/input_label_text_widget.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.imagePath});
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: SizedBox(
          height: 125,
          width: 125,
          child: imagePath?.isNotEmpty == true
              ? CachedNetworkImage(
                  imageUrl: imagePath!,
                  fit: BoxFit.cover,
                  cacheManager: CacheImageManager.instance,
                  placeholder: (context, url) => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              // Image.network(
              //     imagePath,
              //     fit: BoxFit.cover,
              //     loadingBuilder:
              //         (context, child, loadingProgress) {
              //       if (loadingProgress == null) {
              //         return child;
              //       }
              //       return Center(
              //         child: Padding(
              //           padding: const EdgeInsets.all(10),
              //           child: CircularProgressIndicator(
              //             value: loadingProgress
              //                         .expectedTotalBytes !=
              //                     null
              //                 ? loadingProgress
              //                         .cumulativeBytesLoaded /
              //                     loadingProgress
              //                         .expectedTotalBytes!
              //                 : null,
              //           ),
              //         ),
              //       );
              //     },
              //   )
              : Container(
                  color: ColorConstant.dottedBorderColor,
                  child: const Align(
                    alignment: Alignment.center,
                    child: InputLabelText(
                        text: 'Zdjęcie profilowe',
                        overflow: TextOverflow.clip,
                        align: TextAlign.center),
                  ),
                ),
        ),
      ),
    );
  }
}
