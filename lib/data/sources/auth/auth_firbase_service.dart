import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_project/data/models/auth/create_user_req.dart';
import 'package:spotify_project/data/models/auth/edit_user.dart';
import 'package:spotify_project/data/models/auth/signin_user_req.dart';
import 'package:spotify_project/data/models/auth/user.dart';
import 'package:spotify_project/domain/entities/auth/user.dart';

abstract class AuthFirbaseService {
  Future<Either> signup(CreateUserReq createUserReq);
  Future<Either> signin(SigninUserReq signinUserReq);
  Future<Either> getUser();
  Future<Either> editUser(EditUser editUser);
}

class AuthFirbaseServiceImp extends AuthFirbaseService {
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signinUserReq.email, password: signinUserReq.password);
    } on FirebaseAuthException catch (e) {
      String message = '';

      message = 'Invalid email or password';

      return left(message);
    }
    return const Right('signin was successful');
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserReq.email, password: createUserReq.password);
      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set({
        'name': createUserReq.fullName,
        'email': data.user?.email,
        //'mode': ThemeIcon.cMode,
      });
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email';
      } else {
        message = 'Please fill all fields';
      }
      return left(message);
    }
    return const Right('signup was successful');
  }

  @override
  Future<Either> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = await firebaseFirestore
          .collection('Users')
          .doc(firebaseAuth.currentUser?.uid)
          .get();
      UserModel userModel = UserModel.fromJson(user.data()!);
      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);
    } catch (e) {
      return left('an error occurred');
    }
  }

  @override
  Future<Either> editUser(EditUser editUser) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseFirestore
          .collection('Users')
          .doc(firebaseAuth.currentUser?.uid)
          .get();
      FirebaseFirestore.instance.collection('Users').doc(user.id).set({
        'name': editUser.fullName,
        'email': editUser.email,
        'password': editUser.password
      });
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email';
      }
      else{
        message = 'Please fill all fields';

      }
      return left(message);
    }
    return const Right('signup was successful');
  }
}
