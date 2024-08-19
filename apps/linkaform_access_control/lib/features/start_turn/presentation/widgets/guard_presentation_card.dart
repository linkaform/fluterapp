import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_look_and_feel_module/module_exports.dart';

class GuardHolderPresentationCard extends StatelessWidget {
  const GuardHolderPresentationCard({
    required this.guardHolderName,
    required this.guardHolderPosition,
    required this.imageUrl,
    super.key,
  });

  final String guardHolderName;
  final String guardHolderPosition;
  final String imageUrl;
  static const String mockUrl =
      'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                radius: 50,
                child: CachedImageWidget(imageUrl: imageUrl),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  guardHolderName,
                  // aboreto
                  style: GoogleFonts.barlowCondensed(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  guardHolderPosition,
                  style: GoogleFonts.barlowCondensed(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
