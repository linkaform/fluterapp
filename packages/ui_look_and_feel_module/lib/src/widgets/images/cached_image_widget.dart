import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';

class CachedImageWidget extends StatelessWidget {
  final String imageUrl;

  const CachedImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Stack(
        children:  [
          Center(
            child: CircularProgressIndicator(
              color: ColorName.colorUbicacion,
            ),
          ),
          $AssetsImagesGen().logoColored.image(),
        ],
      ),
    );
  }
}