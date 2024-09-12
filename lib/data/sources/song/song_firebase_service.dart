import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_project/data/models/song/song.dart';
import 'package:spotify_project/domain/entities/song/song.dart';
import 'package:spotify_project/domain/usecases/song/is_favorite_song.dart';
import 'package:spotify_project/service_locator.dart';

abstract class SongFirebaseService {
  Future<Either<Failure, List<SongEntity>>> getNewsSongs();
  Future<Either<Failure, List<SongEntity>>> getPlayList();
  Future<Either> addOrRemoveFavoriteSongs(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<SongEntity> nextSong(SongEntity currentSong);
}

class SongFirebaseServiceImp implements SongFirebaseService {
  static List<SongEntity> songs = [];
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
        bool isFavorite = await serviceLocator<IsFavoriteSongUseCase>()
            .call(params: song.reference.id);
        songModel.isFavorite = isFavorite;
        songModel.songId = song.reference.id;
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
        bool isFavorite = await serviceLocator<IsFavoriteSongUseCase>()
            .call(params: song.reference.id);
        songModel.isFavorite = isFavorite;
        songModel.songId = song.reference.id;
        playList.add(songModel.toEntity());
        songs.add(songModel.toEntity());
      }

      return right(playList);
    } catch (e) {
      // Log the actual error for easier debugging
      print('Error fetching songs from Firebase: $e');
      return left(
          ServerFailure(message: e.toString())); // Return more detailed error
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      late bool isFavorite;
      var user = firebaseAuth.currentUser;
      String uId = user!.uid;
      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();
      if (favoriteSongs.docs.isNotEmpty) {
        await favoriteSongs.docs.first.reference.delete();
        isFavorite = false;
      } else {
        await firebaseFirestore
            .collection('Users')
            .doc(uId)
            .collection('Favorites')
            .add({'songId': songId, 'addedDate': Timestamp.now()});
        isFavorite = true;
      }
      return Right(isFavorite);
    } catch (e) {
      return const Left('an error occured');
    }
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = firebaseAuth.currentUser;

      String uId = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();
      if (favoriteSongs.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<SongEntity> nextSong(SongEntity currentSong) async {
    for (int i = 0; i < songs.length; i++) {
      if (currentSong.title == songs[i].title && i + 1 < songs.length) {
        return songs[i + 1];
      }
    }
    return songs[0];
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
