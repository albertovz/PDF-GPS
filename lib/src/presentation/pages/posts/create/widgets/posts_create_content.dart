import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paw_rescue/src/presentation/pages/posts/create/post_create_event.dart';
import 'package:paw_rescue/src/presentation/pages/posts/create/widgets/posts_category.dart';
import 'package:paw_rescue/src/presentation/utils/base_color.dart';
import 'package:paw_rescue/src/presentation/utils/show_select_image_dialog.dart';
import 'package:paw_rescue/src/presentation/utils/show_select_image_dialog_post.dart';
import 'package:paw_rescue/src/presentation/widgets/default_button.dart';
import 'package:paw_rescue/src/presentation/widgets/default_textfield.dart';

class PostsCreateContent extends StatelessWidget {
  PostsCreateEvent vm;

  PostsCreateContent(this.vm) {}

  late GoogleMapController mapController;
  final ValueNotifier<LatLng?> selectedLatLng = ValueNotifier(null);
  Set<Marker> _markers = {};
  double latitud = 0.0;
  double longitud = 0.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              color: BASE_COLOR,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showSelectImageDialogPost(context, vm.pickImage,
                          vm.takePhoto, vm.pickVideo, vm.pickAudio, vm.pickPDF);
                    },
                    child: vm.state.image != null
                        ? Image.file(
                            vm.state.image!,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.35,
                            fit: BoxFit.cover,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/img/gallery.png',
                                height: 150,
                                width: 150,
                              ),
                              const Text(
                                'Selecciona un archivo',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(top: 50, left: 15),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 35,
                          ))),
                ],
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: DefaultTextfield(
                  controller: vm.nameController,
                  // initialValue: vm.state.name.value,
                  label: 'Nombre de la mascota',
                  icon: Icons.control_camera,
                  error: vm.state.name.error,
                  onChanged: (value) {
                    vm.changeName(value);
                  })),
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: DefaultTextfield(
                  controller: vm.descriptionController,
                  // initialValue: vm.state.description.value,
                  label: 'Descripción de la mascota',
                  icon: Icons.description,
                  error: vm.state.description.error,
                  onChanged: (value) {
                    vm.changeDescription(value);
                  })),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 15),
            child: const Text(
              'Raza de la mascota',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          PostsCategory(
              value: 'Perro',
              groupValue: vm.state.category,
              onChanged: (value) {
                vm.changeRadioCategory(value);
              },
              imagePath: 'assets/img/perro.png'),
          PostsCategory(
              value: 'Gato',
              groupValue: vm.state.category,
              onChanged: (value) {
                vm.changeRadioCategory(value);
              },
              imagePath: 'assets/img/gato.png'),
          PostsCategory(
              value: 'Ave',
              groupValue: vm.state.category,
              onChanged: (value) {
                vm.changeRadioCategory(value);
              },
              imagePath: 'assets/img/ave.png'),
          PostsCategory(
              value: 'Roedor',
              groupValue: vm.state.category,
              onChanged: (value) {
                vm.changeRadioCategory(value);
              },
              imagePath: 'assets/img/roedor.png'),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              vm.state.error,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),

          // child: DefaultButton(text: 'AGREGAR UBICACIÓN', onPressed: () {
          //   vm.createPost();
          // })
          
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
            height: 350,
            child: GoogleMap(
                onMapCreated: (GoogleMapController controller) async {
                  mapController = controller;
                  await vm.getLocation(mapController, selectedLatLng, _markers);
                },
                initialCameraPosition: const CameraPosition(
                    target: LatLng(16.6143115, -93.0896307), zoom: 15.0),
                onTap: (LatLng latLng) async {
                  latitud = (latLng.latitude);
                  longitud = (latLng.longitude);
                  await vm.setMarkers(latLng, _markers);
                  selectedLatLng.value = latLng;
                  print(
                      'Latitud: ${latLng.latitude}, Longitud: ${latLng.longitude}');
                  print(
                      'Nuevos valores: Latitud: ${latLng.latitude}, Longitud: ${latLng.longitude}');
                },
                onCameraMove: (CameraPosition position) async {
                  selectedLatLng.value = position.target;
                  print("Latitud desde vmmv: ${vm.state.longitud}");
                },
                // markers:
                // vm.setMarkers(latLng, _markers)
                // markers: {
                //   Marker(
                //     markerId: const MarkerId('Mexico'),
                //     position: LatLng(double.parse(vm.state.latitud),
                //         double.parse(vm.state.longitud)),
                //     infoWindow: const InfoWindow(
                //       title: "Mexico",
                //       snippet: "Mexico City",
                //     ),
                //   )
                // }
                ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: DefaultButton(
                  text: 'CREAR POST',
                  onPressed: () {
                    vm.createPost();
                  }))
        ],
      ),
    );
  }
}
