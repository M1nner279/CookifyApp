import 'dart:io';

import 'package:cookify/core/l10n/my_locale.dart';
import 'package:cookify/features/recipe/recipe_common/presentation/controllers/photo_controller.dart';
import 'package:cookify/features/recipe/recipe_search/presentation/pages/recipe_search_form_page_content.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RecipeFormPhotoField extends StatefulWidget {
  const RecipeFormPhotoField({super.key, required this.controller});

  final PhotoController controller;

  @override
  State<RecipeFormPhotoField> createState() => _RecipeFormPhotoFieldState();
}

class _RecipeFormPhotoFieldState extends State<RecipeFormPhotoField> {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([widget.controller]),
      builder: (context, _) {
        final photos = widget.controller.photos;

        return GestureDetector(
          onTap: () async {
            final selected = await ImagePickerSheet.show(context);
            if (selected != null) {
              widget.controller.add(selected);
            }
          },
          child: Container(
            height: 176.0,
            decoration: BoxDecoration(
              color: const Color(0x1AE5C9A8),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: const Color(0x1AE5C9A8)),
            ),
            child: photos.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add_a_photo_outlined,
                        color: Color(0x99E5C9A8),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        MyLocale.of(context).recipeFormAddPhoto,
                        style: const TextStyle(
                          color: Color(0xB3E5C9A8),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.file(File(photos.first.path), fit: BoxFit.cover),
                        Positioned(
                          top: 12.0,
                          right: 12.0,
                          child: GestureDetector(
                            onTap: () => widget.controller.remove(photos.first),
                            child: Container(
                              padding: const EdgeInsets.all(6.0),
                              decoration: const BoxDecoration(
                                color: Color(0x9930170D),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Color(0xFFFFE6C9),
                                size: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
