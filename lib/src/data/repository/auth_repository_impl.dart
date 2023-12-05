import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paw_rescue/src/core/constants.dart';
import 'package:paw_rescue/src/domain/models/user_data.dart';
import 'package:paw_rescue/src/domain/repository/auth_repository.dart';
import 'package:paw_rescue/src/domain/utils/resource.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  FirebaseAuth _firebaseAuth;
  CollectionReference _usersRef;

  AuthRepositoryImpl(this._firebaseAuth, @Named(USERS) this._usersRef);

  @override
  Future<Resource> login(
      {required String email, required String password}) async {
    try {
      UserCredential data = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return Success(data);
    } on FirebaseException catch (e) {
      return Error(e.message ?? 'Error desconocido');
    }
  }

  @override
  Future<Resource> register(UserData user) async {
    try {
      UserCredential data = await _firebaseAuth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      // user.password = "";
      user.id = data.user?.uid ?? '';
      await _usersRef.doc(user.id).set(user.toJson());
      return Success(data);
    } on FirebaseAuthException catch (e) {
      return Error(e.message ?? "Error desconocido");
    }
  }
  
  @override
  User? get user => _firebaseAuth.currentUser;
  
  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
