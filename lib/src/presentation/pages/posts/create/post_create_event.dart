import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/src/types/marker.dart';
import 'package:location/location.dart';
import 'package:paw_rescue/src/domain/models/post.dart';
import 'package:paw_rescue/src/domain/use_cases/auth/auth_usecases.dart';
import 'package:paw_rescue/src/domain/use_cases/posts/posts_usecases.dart';
import 'package:paw_rescue/src/domain/utils/resource.dart';
import 'package:paw_rescue/src/presentation/pages/posts/create/posts_create_state.dart';
import 'package:paw_rescue/src/presentation/utils/validation_item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostsCreateEvent extends ChangeNotifier {
  PostsCreateState _state = PostsCreateState();
  PostsCreateState get state => _state;

  File? _imageFile;
  File? get imageFile => _imageFile;
  File? _videoFile;
  File? get videoFile => _videoFile;

  AuthUseCases _authUseCases;
  PostsUseCases _postsUseCases;

  Resource _response = Init();
  Resource get response => _response;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  PostsCreateEvent(this._authUseCases, this._postsUseCases) {
    _state =
        _state.copyWith(idUser: _authUseCases.getUser.userSession?.uid ?? '');
    startListeningConnectivityChanges();
  }

  String imagePathKey = 'imagePath';
  String contentTypeKey = 'contentPath';
  String nameKey = 'namePath';
  String descriptionKey = 'descriptionPath';
  String categoryKey = 'categoryPath';
  String id_userKey = 'id_userPath';
  String latitudKey = 'latitudPath';
  String longitudKey = 'longitudPath';
  bool syncing = false;
  Location location = Location();

  getStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString(nameKey));
    print(prefs.getString(descriptionKey));
    print(prefs.getString(imagePathKey));
    print(prefs.getString(contentTypeKey));
  }

  void startListeningConnectivityChanges() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        // Hay conexión a Internet, puedes realizar acciones aquí
        syncLocalPosts();
        print('Conexión restablecida');
        getStatus();

        // Ejecutar el método syncLocalPosts() u otras acciones necesarias
        // syncLocalPosts();
      } else {
        print('Conexión perdida');
      }
    });
  }

  Future<List<Post>> getLocalPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString(imagePathKey);
    String? name = prefs.getString(nameKey);
    String? description = prefs.getString(descriptionKey);
    String? contentType = prefs.getString(contentTypeKey);
    String? category = prefs.getString(categoryKey);
    String? iduser = prefs.getString(id_userKey);
    String? latitud = prefs.getString(latitudKey);
    String? longitud = prefs.getString(longitudKey);
    // File imageRoute = File(imagePath!);

    if (imagePath != null &&
        name != null &&
        description != null &&
        contentType != null &&
        category != null &&
        iduser != null &&
        latitud != null &&
        longitud != null) {
      // Si hay datos guardados localmente, crea un Post y agrégalo a la lista
      Post localPost = Post(
          category: category,
          name: name,
          description: description,
          image: imagePath,
          contentType: contentType,
          idUser: iduser
          // Puedes agregar más campos según tu modelo
          );

      return [localPost];
    } else {
      return []; // No hay datos guardados localmente
    }
  }

  Future<void> syncLocalPosts() async {
    if (syncing) return;

    syncing = true;

    try {
      List<Post> localPosts = await getLocalPosts();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? imagePath = prefs.getString(imagePathKey);
      File imageFile = File(imagePath!);

      for (Post localPost in localPosts) {
        // Realiza el post al servidor utilizando el método create del use case
        Resource response =
            await _postsUseCases.create.launch(localPost, imageFile);

        // Verifica si el post fue exitoso antes de borrarlo localmente
        if (response is Success) {
          response = Success(
              'La conexión se ha reestablecido y se ha creado la publicación con éxito');
          // Borrar los datos locales después de sincronizar con el servidor
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove(imagePathKey);
          prefs.remove(nameKey);
          prefs.remove(descriptionKey);
          prefs.remove(contentTypeKey);
          prefs.remove(categoryKey);
          prefs.remove(id_userKey);
          prefs.remove(latitudKey);
          prefs.remove(longitudKey);
        }
      }
    } finally {
      syncing = false;
    }
  }

  createPost() async {
    // if (_state.isValid()) {
    //   print('Formulario válido');
    //   _response = Loading();
    //   notifyListeners();
    //   _response =
    //       await _postsUseCases.create.launch(_state.toPost(), _state.image!);
    //   notifyListeners();
    // }
    if (_state.isValid()) {
      print('Formulario válido');
      _response = Loading();
      notifyListeners();

      // Verifica si hay conexión a Internet
      if (await isConnected()) {
        // Si hay conexión, realiza el post directamente
        _response =
            await _postsUseCases.create.launch(_state.toPost(), _state.image!);
      } else {
        // Si no hay conexión, guarda la imagen localmente
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(imagePathKey, _state.image!.path);
        prefs.setString(nameKey, _state.name.value);
        prefs.setString(descriptionKey, _state.description.value);
        prefs.setString(contentTypeKey, _state.contentType);
        prefs.setString(categoryKey, _state.category);
        prefs.setString(id_userKey, _state.idUser);
        prefs.setString(latitudKey, _state.latitud);
        prefs.setString(longitudKey, _state.longitud);
        // Puedes guardar el post localmente también si lo necesitas
        // await saveLocalPost(_state.toPost());

        // Actualiza la respuesta para indicar que el post se guardó localmente
        _response =
            Success('Post guardado localmente. Se sincronizará más tarde.');
      }

      notifyListeners();
    }
  }

  Future<bool> isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true; // Hay conexión a Internet
    } else {
      return false; // No hay conexión a Internet
    }
  }

  getLocation(GoogleMapController mapController,
      ValueNotifier<LatLng?> selectedLatLng, Set<Marker> _markers) {
    _getCurrentLocation(mapController, selectedLatLng, _markers);
    notifyListeners();
  }

  setMarkers(LatLng latLng, Set<Marker> _markers) {
    _addMarker(latLng, _markers);
    notifyListeners();
  }

  void _addMarker(LatLng latLng, Set<Marker> _markers) {
    // Agrega un nuevo marcador al conjunto
    _markers.clear();
    _markers.add(
      Marker(
        markerId: MarkerId('currentLocation'),
        position: latLng,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: 'Ubicación seleccionada'),
      ),
    );
    notifyListeners();
  }

  // Future<void> _getCurrentLocation(GoogleMapController mapController,
  //     ValueNotifier<LatLng?> selectedLatLng) async {
  //   Location location = Location();
  //   try {
  //     var currentLocation = await location.getLocation();
  //     LatLng latLng =
  //         LatLng(currentLocation.latitude!, currentLocation.longitude!);
  //     mapController.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15.0));
  //     selectedLatLng.value = latLng;
  //   } catch (e) {
  //     print("Error getting current location: $e");
  //   }
  // }

  Future<void> _getCurrentLocation(GoogleMapController mapController,
      ValueNotifier<LatLng?> selectedLatLng, Set<Marker> _markers) async {
    Location location = Location();
    try {
      var currentLocation = await location.getLocation();
      LatLng latLng =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
      notifyListeners();
      _state = _state.copyWith(
          latitud: (currentLocation.latitude).toString(), error: '');
      _state = _state.copyWith(
          longitud: (currentLocation.longitude).toString(), error: '');
      // Borra marcadores existentes y agrega uno nuevo para la ubicación actual
      _markers = {};
      _markers.add(
        Marker(
          markerId: MarkerId('user_location'),
          position: latLng,
        ),
      );
      mapController.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15.0));
      // Actualiza la posición seleccionada
      selectedLatLng.value = latLng;
      // Actualiza el estado para que se vuelva a construir el mapa con el nuevo marcador
      notifyListeners();
    } catch (e) {
      print("Error getting current location: $e");
    }
  }

  changeName(String value) {
    if (value.length >= 3) {
      _state = _state.copyWith(name: ValidationItem(value: value, error: ''));
    } else {
      _state = _state.copyWith(
          name: ValidationItem(value: value, error: 'Al menos 3 carácteres'));
    }
    notifyListeners();
  }

  changeDescription(String value) {
    if (value.length >= 6) {
      _state =
          _state.copyWith(description: ValidationItem(value: value, error: ''));
    } else {
      _state = _state.copyWith(
          description:
              ValidationItem(value: value, error: 'Al menos 6 carácteres'));
    }
    notifyListeners();
  }

  changeRadioCategory(String value) {
    _state = _state.copyWith(category: value);
    print('Radio : ${_state.category}');
    notifyListeners();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imageFile = File(image.path);
      _state = _state.copyWith(image: _imageFile, contentType: 'photo');
      notifyListeners();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(imagePathKey, _imageFile!.path);
      print(prefs.getString(imagePathKey));
    }
  }

  Future<void> takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _imageFile = File(image.path);
      _state = _state.copyWith(image: _imageFile, contentType: 'photo');
      notifyListeners();
    }
  }

  Future<void> pickVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickVideo(source: ImageSource.gallery);
    if (image != null) {
      _imageFile = File(image.path);
      _state = _state.copyWith(image: _imageFile, contentType: 'video');
      notifyListeners();
    }
  }

  Future<void> pickAudio() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result != null) {
      final File file = File(result.files.single.path!);
      _imageFile = file;
      _state = _state.copyWith(image: _imageFile, contentType: 'audio');
      notifyListeners();
    }
  }

  Future<void> pickPDF() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );

    if (result != null) {
      final File file = File(result.files.single.path!);
      _imageFile = file;
      _state = _state.copyWith(image: _imageFile, contentType: 'pdf');
      notifyListeners();
    }
  }

  resetResponse() {
    _response = Init();
    notifyListeners();
  }

  resetState() {
    // _state = PostsCreateState();
    _state.image = null;
    _state.category = '';
    nameController.clear();
    descriptionController.clear();
    notifyListeners();
  }
}
