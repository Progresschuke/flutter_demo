import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

File? _selectedImage;

class ProfileImageInput extends StatefulWidget {
  const ProfileImageInput({
    super.key,
    required this.onPickImage,
    required this.onSaveProfile,
  });

  final void Function(File pickImage) onPickImage;
  final void Function() onSaveProfile;

  @override
  State<ProfileImageInput> createState() => _ProfileImageInputState();
}

class _ProfileImageInputState extends State<ProfileImageInput> {
  final imagePicker = ImagePicker();

  void _selectImage() async {
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _selectedImage = File(pickedImage.path);
    });

    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 90,
          foregroundImage:
              _selectedImage != null ? FileImage(_selectedImage!) : null,
        ),
        Row(
          children: [
            OutlinedButton.icon(
              icon: const Icon(Icons.camera),
              onPressed: _selectImage,
              label: const Text('select image'),
            ),
            ElevatedButton(
                onPressed: widget.onSaveProfile, child: const Text('save'))
          ],
        )
      ],
    );
  }
}
