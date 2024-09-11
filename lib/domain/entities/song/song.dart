import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity {
  final bool isFavorite;
  final String title;
  final String artist;
  final String duration;
  final Timestamp releaseDate;
  final String songId;

  SongEntity(
    {
    required this.songId,
    required this.isFavorite,
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
  });
}
