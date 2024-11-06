import 'package:niamu_project/core/error/failure.dart';
import 'package:niamu_project/feature/places/domain/models/favorite_place_model.dart';

sealed class FavoritePlaceState {
  const FavoritePlaceState();
}

class LoadingFavoritePlaces extends FavoritePlaceState {
  const LoadingFavoritePlaces();
}

class ErrorFavoritePlaces extends FavoritePlaceState {
  final Failure? error;

  const ErrorFavoritePlaces({this.error});
}

class SuccessFavoritePLaces extends FavoritePlaceState {
  final List<FavoritePlaceModel> favoritePlaces;

  const SuccessFavoritePLaces(this.favoritePlaces);
}

class EmptyFavoritePlaces extends FavoritePlaceState {
  const EmptyFavoritePlaces();
}