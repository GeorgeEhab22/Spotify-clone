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
  Future<Either> getUserFavoriteSongs();
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
 @override
Future<Either> addOrRemoveFavoriteSongs(String songId) async {
  try {
    // Ensure the songId is not empty before proceeding
    if (songId.isEmpty) {
      return const Left('Invalid song ID');
    }

    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    late bool isFavorite;
    var user = firebaseAuth.currentUser;
    String uId = user!.uid;

    // Check if the song is already in the favorites collection
    QuerySnapshot favoriteSongs = await firebaseFirestore
        .collection('Users')
        .doc(uId)
        .collection('Favorites')
        .where('songId', isEqualTo: songId)
        .get();

    if (favoriteSongs.docs.isNotEmpty) {
      // If the song is already in favorites, remove it
      await favoriteSongs.docs.first.reference.delete();
      isFavorite = false;
    } else {
      // If the song is not in favorites, add it
      await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .doc(songId)  // Use the songId as the document ID to prevent auto-generated ID issues
          .set({
            'songId': songId,
            'addedDate': Timestamp.now(),
          });
      isFavorite = true;
    }

    return Right(isFavorite);
  } catch (e) {
    return const Left('An error occurred');
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

  @override
  Future<Either> getUserFavoriteSongs() async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = firebaseAuth.currentUser;
      if (user == null) {
        return const Left('No user is logged in');
      }

      List<SongEntity> favoriteSongs = [];
      String uId = user.uid;

      QuerySnapshot favoritesSnapshot = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .get();

     for (var element in favoritesSnapshot.docs) {
String songId = (element.data() as Map<String, dynamic>)['songId'] ?? '';
    
    var songDoc = await firebaseFirestore.collection('songs').doc(songId).get();
   

    if (songDoc.exists && songDoc.data() != null) {
        var songData = songDoc.data() as Map<String, dynamic>;
        SongModel songModel = SongModel.fromJson(songData);
        songModel.isFavorite = true;
        songModel.songId = songId;  // Make sure the correct songId is assigned here.
        favoriteSongs.add(songModel.toEntity());
    }
}

      return Right(favoriteSongs);
    } catch (e) {
      print(e);
      return const Left('An error occurred');
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
