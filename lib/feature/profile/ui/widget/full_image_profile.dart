import 'dart:io';

import 'package:flutter/material.dart';

class FullImageView extends StatelessWidget {
  final File? imageFile;
  final String? imageAsset;
  const FullImageView({super.key, this.imageFile, this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Hero(
        tag: 'profile_image',
        child: InteractiveViewer(
          child: Center(
            child: imageFile != null
                ? Image.file(
                    imageFile!,
                    
                    
                  )
                : Image.asset(
                    imageAsset ?? '',
                
                  
                  ),
          ),
        ),
      ),
    );
  }
}