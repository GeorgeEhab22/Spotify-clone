import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_project/domain/entities/song/song.dart';

class SongModel extends SongEntity {
  SongModel({
    required super.artist,
    required String duration,
    required super.releaseDate,
    required super.title,
  }) : super(duration: duration.toString());

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
