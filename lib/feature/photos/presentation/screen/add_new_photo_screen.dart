import 'dart:io';

import 'package:dp_project/core/di.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_app_bar.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_dropdown_field.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_primary_button.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_radio_buttons.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_secondary_button.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_text_field.dart';
import 'package:dp_project/feature/photos/domain/entity/photo.dart';
import 'package:dp_project/feature/photos/presentation/controller/photo_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddNewPhotoScreen extends HookConsumerWidget {
  const AddNewPhotoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<File?> imageFile = ValueNotifier<File?>(null);
    final authUser = FirebaseAuth.instance.currentUser;

    Future<void> pickImage(ImageSource source) async {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        imageFile.value = File(pickedFile.path);
      }
    }

    final formGroup = FormGroup({
      'description': FormControl<String>(
        validators: [Validators.required],
      ),
      'hashtag': FormControl<String>(
        validators: [Validators.required],
      ),
      'format': FormControl<String>(
        validators: [Validators.required],
      ),
      'size': FormControl<String>(
        validators: [Validators.required],
      ),
    });

    return Scaffold(
      appBar:
          const CustomAppBar(title: "Add New Photo", isBackButtonVisible: true),
      body: SingleChildScrollView(
        child: ReactiveForm(
          formGroup: formGroup,
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: ValueListenableBuilder<File?>(
                  valueListenable: imageFile,
                  builder: (context, file, _) {
                    return file != null
                        ? Image.file(file)
                        : const Center(child: Text("No image selected"));
                  },
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextField(
                  formControlName: 'description',
                  labelText: 'Description',
                  validationMessages: {
                    ValidationMessage.required: (_) => 'Please enter photo '
                        'description',
                  },
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextField(
                  formControlName: 'hashtag',
                  labelText: 'Hashtags',
                  validationMessages: {
                    ValidationMessage.required: (_) =>
                        'Please enter your password',
                  },
                ),
              ),
              const SizedBox(height: 8),
              const CustomRadioButtons(
                items: ['.jpg', '.png', '.bmp'],
                formControlName: 'format',
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomDropdownField(
                  labelText: 'Chose picture size',
                  formControlName: 'size',
                  items: [
                    DropdownMenuItem(
                      value: '2160x2160',
                      child: Text('2160 x 2160'),
                    ),
                    DropdownMenuItem(
                      value: '1280x720',
                      child: Text('1280 x 720'),
                    ),
                    DropdownMenuItem(
                      value: '582x582',
                      child: Text('582 x 582'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomSecondaryButton(
                  onPressed: () => pickImage(ImageSource.gallery),
                  labelText: 'Pick Image from Gallery',
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomSecondaryButton(
                  onPressed: () => pickImage(ImageSource.camera),
                  labelText: 'Take Photo with Camera',
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomPrimaryButton(
                  labelText: 'Add',
                  onPressed: () {
                    formGroup.markAllAsTouched();
                    if (formGroup.valid &&
                        imageFile.value != null &&
                        authUser != null) {
                      ref.read(photoNotifierProvider.notifier).addPhoto(
                            context,
                            Photo(
                              id: null,
                              description:
                                  formGroup.value['description'].toString(),
                              author:
                                  authUser.displayName ?? authUser.email ?? '',
                              uid: authUser.uid,
                              hashtags: formGroup.value['hashtag'].toString(),
                              size: imageFile.value!.lengthSync().toString(),
                              uploadDate: DateTime.now(),
                              url: '',
                            ),
                            imageFile.value!,
                            formGroup.value['format'].toString(),
                            formGroup.value['size'].toString(),
                          );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
