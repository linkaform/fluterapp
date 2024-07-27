import 'package:flutter/material.dart';
import 'package:ui_look_and_feel_module/module_exports.dart';

class GuardHolderPresentationCard extends StatelessWidget {
  const GuardHolderPresentationCard({
    required this.guardHolderName,
    required this.guardHolderPosition,
    required this.guardHolderEmail,
    super.key,
  });

  final String guardHolderName;
  final String guardHolderPosition;
  final String guardHolderEmail;

  static const String imageUrl =
      'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.only(top: 8, bottom: 20),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child:  Row(
          children: [
            const CircleAvatar(
              radius: 30,
              child: CachedImageWidget(imageUrl: imageUrl),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  guardHolderName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(guardHolderPosition),
                Text(guardHolderEmail),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
