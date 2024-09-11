part of 'favorite_button_cubit.dart';

@immutable
sealed class FavoriteButtonState {}

class FavoriteButtonInitial extends FavoriteButtonState {}

class FavoriteButtonUpdated extends FavoriteButtonState {
  final isFavorite;
  FavoriteButtonUpdated({required this.isFavorite});
}
