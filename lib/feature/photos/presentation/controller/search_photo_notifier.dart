import 'package:dp_project/feature/photos/domain/entity/photo.dart';
import 'package:dp_project/feature/photos/domain/usecase/photo_use_case.dart';
import 'package:dp_project/feature/photos/presentation/controller/state/search_photo_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dp_project/core/di.dart';

class SearchPhotoNotifier extends Notifier<SearchPhotoState> {
  late final PhotoUseCase _photoUseCase;
  List<Photo>? photos;

  @override
  SearchPhotoState build() {
    _photoUseCase = ref.read(photoUseCasesProvider);
    searchedPhotos('');
    return state;
  }

  Future<void> searchedPhotos(String attribute) async {
    state = const LoadingSearchPhotos();
    final result = await _photoUseCase.searchPhoto(attribute);
    result.fold(
      (failure) {
        ref
            .read(errorLogsNotifierProvider.notifier)
            .addErrorLog('getSearchedPhotos', failure.toString());
        return state = ErrorSearchPhotos(error: failure);
      },
      (photos) {
        if (photos == null || photos.isEmpty) {
          ref
              .read(infoLogsNotifierProvider.notifier)
              .addInfoLog('getSearchedPhotos'
                  ' empty');
          state = const SuccessSearchPhotos([]);
        } else {
          ref
              .read(infoLogsNotifierProvider.notifier)
              .addInfoLog('getSearchedPhotos '
                  'success');
          photos = photos;
          state = SuccessSearchPhotos(photos);
        }
      },
    );
  }
}
