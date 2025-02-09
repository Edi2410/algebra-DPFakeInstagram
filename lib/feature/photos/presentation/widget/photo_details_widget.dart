import 'package:dp_project/core/di.dart';
import 'package:dp_project/core/style/style_extensions.dart';
import 'package:dp_project/feature/photos/domain/entity/photo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhotoDetailsWidget extends ConsumerWidget {
  final Photo photo;

  const PhotoDetailsWidget({super.key, required this.photo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = FirebaseAuth.instance.currentUser;

    bool showDownloadButton = authUser != null;

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
            Flexible(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: context.backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          transform: Matrix4.translationValues(-40.0, -20.0, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: LinearGradient(
                              colors: [
                                context.primaryColor,
                                context.secondaryColor,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: showDownloadButton
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
                        ),
                      ),
                      Text(
                        photo.author,
                        style: context.textTitle.copyWith(
                          fontSize: 24,
                        ),
                      ),
                      Text(photo.uploadDate.toString(),
                          style: context.textStandard),
                      const SizedBox(height: 8),
                      Text(
                        photo.hashtags,
                        overflow: TextOverflow.ellipsis,
                        style: context.textCardSmall.copyWith(
                          color: context.textColor,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        photo.hashtags,
                        style: context.textDescription,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
