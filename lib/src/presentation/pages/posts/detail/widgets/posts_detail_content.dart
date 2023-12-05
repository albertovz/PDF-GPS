import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paw_rescue/src/domain/models/post.dart';
import 'package:paw_rescue/src/presentation/pages/posts/detail/posts_detail_event.dart';
import 'package:paw_rescue/src/presentation/pages/posts/detail/widgets/posts_detail_userinfo.dart';
import 'package:paw_rescue/src/presentation/utils/base_color.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:video_player/video_player.dart';

class PostsDetailContent extends StatelessWidget {
  PostsDetailEvent vm;
  Post postArg;
  late GoogleMapController mapController;
  final ValueNotifier<LatLng?> selectedLatLng = ValueNotifier(null);
  Set<Marker> _markers = {};

  PostsDetailContent(this.vm, this.postArg);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Image(
              //   image: NetworkImage(postArg.image),
              //   height: 300,
              //   width: double.infinity,
              //   fit: BoxFit.cover,
              // ),
              postArg.contentType == 'photo'
                  ? Container(
                      child: Image(
                        image: NetworkImage(postArg.image),
                        width: double.infinity,
                        height: 600,
                        fit: BoxFit.cover,
                      ),
                    )
                  : postArg.contentType == 'pdf'
                      ? Container(
                          height: MediaQuery.of(context).size.height,
                          child: SfPdfViewer.network(postArg.image),
                        )
                      : Container(
                          height: 450,
                          child: Chewie(
                            controller: ChewieController(
                              videoPlayerController:
                                  VideoPlayerController.network(postArg.image),
                              aspectRatio: 16 / 9,
                              autoPlay: false,
                              looping: false,
                            ),
                          ),
                        ),
              Container(
                margin: const EdgeInsets.only(top: 50, left: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 30,
                    )),
              )
            ],
          ),
          FutureBuilder(
              future: vm.getUser(postArg.idUser),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container();
                }
                final data = snapshot.data;
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 90,
                  child: Card(
                      color: Colors.white12, child: PostsDetailUserInfo(data!)),
                );
              }),
          Container(
            margin: const EdgeInsets.only(left: 25, top: 10),
            child: Text(
              postArg.name,
              style: const TextStyle(
                  color: BASE_COLOR, fontWeight: FontWeight.bold, fontSize: 19),
            ),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.only(left: 20, top: 15),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white12),
            child: Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
              children: [
                if (postArg.category == 'Perro') ...[
                  Image.asset('assets/img/perro.png')
                ] else if (postArg.category == 'Gato') ...[
                  Image.asset('assets/img/gato.png')
                ] else if (postArg.category == 'Ave') ...[
                  Image.asset('assets/img/ave.png')
                ] else if (postArg.category == 'Roedor') ...[
                  Image.asset('assets/img/roedor.png')
                ],
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    postArg.category,
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                  ),
                )
              ],
            ),
          ),
          const Divider(
            color: Colors.white60,
            endIndent: 30,
            indent: 30,
            height: 50,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: const Text(
              'DESCRIPCIÓN',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Text(
              postArg.description,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
            height: 350,
            child: GoogleMap(
                onMapCreated: (GoogleMapController controller) async {
                  mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(double.parse(postArg.latitud),
                      double.parse(postArg.longitud)), zoom: 15.0
                ),
                onTap: (LatLng latLng) async {
                  selectedLatLng.value = latLng;
                  print(
                      'Latitud: ${latLng.latitude}, Longitud: ${latLng.longitude}');
                  print(
                      'Nuevos valores: Latitud: ${latLng.latitude}, Longitud: ${latLng.longitude}');
                },
                onCameraMove: (CameraPosition position) async {
                  selectedLatLng.value = position.target;
                  // print("Latitud desde vmmv: ${vm.state.longitud}");
                },
                // markers:
                // vm.setMarkers(latLng, _markers)
                markers: {
                  Marker(
                    markerId: const MarkerId('Mexico'),
                    position: LatLng(double.parse(postArg.latitud),
                        double.parse(postArg.longitud)),
                    infoWindow: const InfoWindow(
                      title: "Mexico",
                      snippet: "Mexico City",
                    ),
                  )
                }),
          ),
        ],
      ),
    );
  }
}
