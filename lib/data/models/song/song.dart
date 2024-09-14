import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_project/domain/entities/song/song.dart';

class SongModel {
  String? title;
  String? artist;
  String? duration;
  Timestamp? releaseDate;
  bool? isFavorite;
  String? songId;

  SongModel(
      {required this.title,
      required this.artist,
      required this.duration,
      required this.releaseDate,
      required this.isFavorite,
      required this.songId});

 SongModel.fromJson(Map<String, dynamic> data) {
  title = data['title'] ?? 'Unknown Title'; // Provide a default if null
  artist = data['artist'] ?? 'Unknown Artist'; // Provide a default if null
  duration = data['duration'] ?? '0:00'; // Provide a default duration
  releaseDate = data['releaseDate'] ?? Timestamp.now(); // Default to current time
  isFavorite = false; // Default to false for favorites if not present
  songId = ''; // Provide a default empty string for songId if null
}

}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title ?? 'Unknown Title', // Ensure a non-null title
      artist: artist ?? 'Unknown Artist', // Ensure a non-null artist
      duration: duration ?? '0:00', // Ensure a non-null duration
      releaseDate: releaseDate ?? Timestamp.now(), // Ensure a non-null releaseDate
      isFavorite: isFavorite ?? false, // Ensure a non-null isFavorite flag
      songId: songId ?? '', // Ensure a non-null songId
    );
  }
}
