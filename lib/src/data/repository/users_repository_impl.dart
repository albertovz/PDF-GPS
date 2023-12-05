import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:paw_rescue/src/core/constants.dart';
import 'package:paw_rescue/src/domain/models/user_data.dart';
import 'package:paw_rescue/src/domain/repository/users_repository.dart';
import 'package:paw_rescue/src/domain/utils/resource.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';

@Injectable(as: UsersRepository)
class UsersRepositoryImpl implements UsersRepository {
  CollectionReference _usersRef;
  Reference _usersStorageRef;

  UsersRepositoryImpl(
      @Named(USERS) this._usersRef, @Named(USERS) this._usersStorageRef);

  @override
  Stream<Resource<UserData>> getUserById(String id) {
    try {
      final data = _usersRef.doc(id).snapshots(includeMetadataChanges: true);
      final dataMap = data.map((doc) =>
          Success(UserData.fromJson(doc.data() as Map<String, dynamic>)));
      return dataMap;
    } on FirebaseException catch (e) {
      throw Error(e.message ?? 'Error desconocido');
    }
  }

  @override
  Future<Resource<String>> updateWithoutImage(UserData userData) async {
    try {
      Map<String, dynamic> map = {
        'username': userData.username,
        'image': userData.image
      };
      print('id sin imagen: ${userData.id}');
      final data = await _usersRef.doc(userData.id).update(map);
      return Success('El usuario se ha actualizado correctamente');
    } on FirebaseException catch (e) {
      return Error(e.message ?? 'Error desconocido');
    }
  }

  @override
  Future<Resource<String>> updateWithImage(
      UserData userData, File image) async {
    try {
      String name = basename(image.path);
      TaskSnapshot uploadTask = await _usersStorageRef
          .child(name)
          .putFile(image, SettableMetadata(contentType: 'image/png'));
      String url = await uploadTask.ref.getDownloadURL();

      Map<String, dynamic> map = {'username': userData.username, 'image': url};
      final data = await _usersRef.doc(userData.id).update(map);
      return Success('El usuario se ha actualizado correctamente');
    } on FirebaseException catch (e) {
      return Error(e.message ?? 'Error desconocido');
    }
  }

  @override
  Future<UserData> getUserByIdOnce(String id) async {
    try {
      final document = await _usersRef.doc(id).get();
      if (document.exists) {
        UserData userData =
            UserData.fromJson(document.data() as Map<String, dynamic>);
        return userData;
      }
      return UserData();
    } on FirebaseException catch (e) {
      throw Error(e.message ?? 'Error desconocido');
    }
  }
}
