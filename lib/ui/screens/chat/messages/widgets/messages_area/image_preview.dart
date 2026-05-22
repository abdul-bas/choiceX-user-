import 'dart:typed_data';
import 'package:coice/core/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview(
      {super.key, required this.bytes, required this.onRemove});

  final Uint8List bytes;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.chatBubbleReceiver,        
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.white),      
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(bytes,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: IconButton(                          
              onPressed: onRemove,
              padding: const EdgeInsets.all(3),
              iconSize: 12,
              icon: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: AppColors.black,                
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close,
                    size: 12, color: AppColors.white),   
              ),
            ),
          ),
        ],
      ),
    );
  }
}
