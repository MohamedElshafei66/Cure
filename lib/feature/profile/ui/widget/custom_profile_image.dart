import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:round_7_mobile_cure_team3/core/utils/app_icons.dart';

class CustomProfileImage extends StatefulWidget {
  final String imageAsset;
  final bool isNetwork;

  const CustomProfileImage({
    super.key,
    required this.imageAsset,
    required this.isNetwork,
  });

  @override
  State<CustomProfileImage> createState() => _CustomProfileImageState();
}

class _CustomProfileImageState extends State<CustomProfileImage> {
  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      if (!mounted) return;
      setState(() => _selectedImage = File(pickedFile.path));
    }
  }

  void _showOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Choose from gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take a photo"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const fallbackAsset = "assets/images/profile_image.png";

    ImageProvider imageProvider;
    if (_selectedImage != null) {
      imageProvider = FileImage(_selectedImage!);
    } else if (widget.isNetwork && widget.imageAsset.isNotEmpty) {
      imageProvider = NetworkImage(widget.imageAsset);
    } else {
      imageProvider = const AssetImage(fallbackAsset);
    }

    return GestureDetector(
      onTap: _showOptions,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: imageProvider,
            onBackgroundImageError: (_, __) {
             
            },
          ),
         
        ],
      ),
    );
  }
}
