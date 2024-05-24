import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_app/helper/cache_image_manager.dart';
import 'package:flutter_mobile_app/view/widgets/screen_positioning_widget.dart';

class ExercisesCategoryItemImageSection extends StatelessWidget {
  const ExercisesCategoryItemImageSection({super.key, required this.image});
  final String? image;

  @override
  Widget build(BuildContext context) {
    return image != null
        ? CachedNetworkImage(
            imageUrl: image!,
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
        : FlutterLogo(
            size: ScreenMaxWitdhRatio.heightResize(context, 0.15),
          );
  }
}
