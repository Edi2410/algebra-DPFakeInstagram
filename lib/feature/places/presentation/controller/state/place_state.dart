
import 'package:firebase_auth/firebase_auth.dart';
import 'package:niamu_project/core/error/failure.dart';
import 'package:niamu_project/feature/places/domain/entity/place.dart';

sealed class PlacesState {
  const PlacesState();
}

class LoadingPlaces extends PlacesState {
  const LoadingPlaces();
}

class ErrorPlaces extends PlacesState {
  final Failure? error;

  const ErrorPlaces({this.error});
}

class SuccessPlaces extends PlacesState {
  final List<Place> places;

  const SuccessPlaces(this.places);
}

class EmptyPlaces extends PlacesState {
  const EmptyPlaces();
}