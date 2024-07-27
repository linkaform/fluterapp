import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ButtonActionWidget extends ConsumerWidget {
  
   const ButtonActionWidget({
     required this.label,
     required this.butttonColor,
     super.key,
   });
  
  final String label;
  final Color butttonColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(160, 40),
        backgroundColor: butttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () => context.pop(),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
//
// showDialog<void>(
// context: context,
// builder: (context) => Dialog(
// child: ConstrainedBox(
// constraints: BoxConstraints(
// maxHeight: MediaQuery.of(context).size.height * 0.8,
// maxWidth: MediaQuery.of(context).size.width * 0.8,
// ),
// child: IntrinsicHeight(
// child: Padding(
// padding: const EdgeInsets.all(16),
// child: Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// ElevatedButton(
// style: ElevatedButton.styleFrom(
// minimumSize: const Size(100, 40),
// backgroundColor: Colors.green[600],
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8),
// ),
// ),
// onPressed: () => context.pop(),
// child: const Text(
// 'OK',
// style: TextStyle(
// color: Colors.white,
// ),
// ),
// ),
// ],
// ),
// ),
// ),
// ),
// ),
// )