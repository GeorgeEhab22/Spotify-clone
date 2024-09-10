import 'package:spotify_project/domain/entities/song/song.dart';

abstract class PlaylistState {}

class PlayListLoading extends PlaylistState {}

class PlayListLoaded extends PlaylistState {
  final List<SongEntity> songs;

  PlayListLoaded({required this.songs});

}

class PlayListLoadFailure extends PlaylistState {}
