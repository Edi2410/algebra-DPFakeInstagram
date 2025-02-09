import 'package:dp_project/core/di.dart';
import 'package:dp_project/core/style/style_extensions.dart';
import 'package:dp_project/feature/photos/domain/entity/photo.dart';
import 'package:dp_project/feature/photos/presentation/widget/edit_photo_widget.dart';
import 'package:dp_project/feature/photos/presentation/widget/photo_details_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PhotoCard extends ConsumerWidget {
  final Photo photo;

  const PhotoCard({
    super.key,
    required this.photo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = FirebaseAuth.instance.currentUser;
    final userData = ref.read(userDataNotifierProvider.notifier).user;

    bool showDownloadButton = authUser != null;
    bool showEditButton = authUser != null && userData != null;

    if (showEditButton &&
        (authUser.uid == photo.uid || userData.isAdministrator)) {
      showEditButton = true;
    }

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (_) {
              return PhotoDetailsWidget(photo: photo);
            });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              context.primaryColor,
              context.secondaryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    photo.url!,
                    width: 96,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      photo.author,
                      overflow: TextOverflow.ellipsis,
                      style: context.textCardTitle.copyWith(
                        color: context.backgroundColor,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      photo.uploadDate.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textCardSubtitle.copyWith(
                        color: context.backgroundColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      photo.hashtags,
                      overflow: TextOverflow.ellipsis,
                      style: context.textCardSmall.copyWith(
                        color: context.backgroundColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    showDownloadButton
                        ? IconButton(
                            icon: Icon(
                              Icons.download,
                              color: context.backgroundColor,
                            ),
                            onPressed: () {
                              ref
                                  .read(photoNotifierProvider.notifier)
                                  .downloadPhoto(context, photo.url!);
                            },
                          )
                        : const SizedBox(),
                    showEditButton
                        ? IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: context.backgroundColor,
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (_) {
                                    return EditPhotoDetailsWidget(photo: photo);
                                  });
                            },
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
