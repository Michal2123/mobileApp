import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/helper/cache_image_manager.dart';

class DetailProfileMultiSourceImage extends StatelessWidget {
  const DetailProfileMultiSourceImage({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: imagePath.isNotEmpty
          ? imagePath.contains('http')
              ? CachedNetworkImage(
                  imageUrl: imagePath,
                  fit: BoxFit.cover,
                  cacheManager: CacheImageManager.instance,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              // Image.network(
              //     swipeProfileDogModel.photo,
              //     fit: BoxFit.cover,
              //     height: 125,
              //     width: 125,
              //     loadingBuilder:
              //         (context, child, loadingProgress) {
              //       if (loadingProgress == null) return child;
              //       return Center(
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
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
              : Image.file(
                  File(imagePath),
                  fit: BoxFit.cover,
                )
          : Container(
              color: Colors.amber,
            ),
    );
  }
}
