import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_project/domain/entities/song/song.dart';

class SongModel extends SongEntity {
  SongModel({
    required String artist,
    required String duration,
    required Timestamp releaseDate,
    required String title,
  }) : super(artist: artist, duration: duration.toString(), releaseDate: releaseDate, title: title);

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      artist: json['artist'] ?? '',
      duration: json['duration'].toString() ?? '',
      releaseDate: json['releaseDate'] ,  // Converting Firestore Timestamp to DateTime
      title: json['title'] ?? '',
    );
  }

  // Convert SongModel to SongEntity
  SongEntity toEntity() {
    return SongEntity(
      artist: artist,
      duration: duration,
      releaseDate: releaseDate,
      title: title,
    );
  }
}
