import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:spotify_project/data/models/song/song.dart';
import 'package:spotify_project/domain/entities/song/song.dart';

abstract class SongFirebaseService {
  Future<Either<Failure, List<SongEntity>>> getNewsSongs();
  Future<Either<Failure, List<SongEntity>>> getPlayList();
}

class SongFirebaseServiceImp implements SongFirebaseService {
  @override
  Future<Either<Failure, List<SongEntity>>> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];

      // Fetch the songs collection from Firestore ordered by releaseDate
      var data = await FirebaseFirestore.instance
          .collection('songs')
          .orderBy('releaseDate', descending: false)
          .limit(3)
          .get();

      // Iterate through documents and convert each to a SongEntity
      for (var song in data.docs) {
        var songModel = SongModel.fromJson(song.data());
        songs.add(songModel.toEntity());
      }

      return right(songs);
    } catch (e) {
      // Log the actual error for easier debugging
      print('Error fetching songs from Firebase: $e');
      return left(
          ServerFailure(message: e.toString())); // Return more detailed error
    }
  }

  @override
  Future<Either<Failure, List<SongEntity>>> getPlayList() async {
    try {
      List<SongEntity> playList = [];

      // Fetch the songs collection from Firestore ordered by releaseDate
      var data = await FirebaseFirestore.instance
          .collection('songs')
          .orderBy('releaseDate', descending: true)
          .get();

      // Iterate through documents and convert each to a SongEntity
      for (var song in data.docs) {
        var songModel = SongModel.fromJson(song.data());
        playList.add(songModel.toEntity());
      }

      return right(playList);
    } catch (e) {
      // Log the actual error for easier debugging
      print('Error fetching songs from Firebase: $e');
      return left(
          ServerFailure(message: e.toString())); // Return more detailed error
    }
  }
}
// core/error/failure.dart

abstract class Failure {
  final String message;

  Failure(this.message);
}

// For general server failures (e.g., network errors, Firebase issues)
class ServerFailure extends Failure {
  ServerFailure({String message = "A server error occurred"}) : super(message);
}

// For authentication failures
class AuthFailure extends Failure {
  AuthFailure({String message = "Authentication failed"}) : super(message);
}

// For cache failures (e.g., local storage issues)
class CacheFailure extends Failure {
  CacheFailure({String message = "Cache error occurred"}) : super(message);
}

// You can also extend this to other types of failures like validation, etc.
