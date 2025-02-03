import 'package:dp_project/core/di.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_primary_button.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_text_field.dart';
import 'package:dp_project/feature/photos/domain/entity/photo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EditPhotoDetailsWidget extends HookConsumerWidget {
  final Photo photo;

  const EditPhotoDetailsWidget({super.key, required this.photo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = FirebaseAuth.instance.currentUser;

    final formGroup = FormGroup({
      'description': FormControl<String>(
        validators: [Validators.required],
        value: photo.description,
      ),
      'hashtag': FormControl<String>(
        validators: [Validators.required],
        value: photo.hashtags,
      ),
    });

    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(photo.url!),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              flex: 2,
              child: ReactiveForm(
                formGroup: formGroup,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: CustomTextField(
                        formControlName: 'description',
                        labelText: 'Description',
                        onChanged: (control) {
                          formGroup.control('description').value = control.value;
                        },
                        validationMessages: {
                          ValidationMessage.required: (_) =>
                              'Please enter photo '
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
                        onChanged: (control) {
                          formGroup.control('hashtag').value = control.value;
                        },
                        validationMessages: {
                          ValidationMessage.required: (_) =>
                              'Please enter your password',
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: CustomPrimaryButton(
                        labelText: 'Edit',
                        onPressed: () {
                          formGroup.markAllAsTouched();
                          if (formGroup.valid && authUser != null) {
                            ref.read(photoNotifierProvider.notifier).editPhoto(
                                  context,
                                  Photo(
                                    id: photo.id,
                                    description: formGroup.control('description')
                                        .value,
                                    author: photo.author,
                                    uid: photo.uid,
                                    hashtags: formGroup.control('hashtag').value,
                                    size: photo.size,
                                    uploadDate: photo.uploadDate,
                                    url: photo.url,
                                  ),
                                );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
