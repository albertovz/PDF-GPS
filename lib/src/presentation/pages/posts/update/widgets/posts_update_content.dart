import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:paw_rescue/src/domain/models/post.dart';
import 'package:paw_rescue/src/presentation/pages/posts/create/widgets/posts_category.dart';
import 'package:paw_rescue/src/presentation/pages/posts/update/posts_update_event.dart';
import 'package:paw_rescue/src/presentation/utils/base_color.dart';
import 'package:paw_rescue/src/presentation/utils/show_select_image_dialog.dart';
import 'package:paw_rescue/src/presentation/widgets/default_button.dart';
import 'package:paw_rescue/src/presentation/widgets/default_textfield.dart';

class PostsUpdateContent extends StatelessWidget {
  PostsUpdateEvent vm;
  Post postArg;

  PostsUpdateContent(this.vm, this.postArg);

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
                      showSelectImageDialog(
                          context, vm.pickImage, vm.takePhoto);
                    },
                    child: vm.imageFile != null
                        ? Image.file(
                            vm.imageFile!,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.35,
                            fit: BoxFit.cover,
                          )
                        : vm.state.image.isNotEmpty
                            ? Image.network(
                                vm.state.image,
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                fit: BoxFit.cover,
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Image.asset(
                                      'assets/img/gallery.png',
                                      height: 150,
                                      width: 150,
                                    ),
                                  ),
                                  const Text(
                                    'Selecciona una imagen',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
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
                  initialValue: postArg.name,
                  label: 'Nombre del juego',
                  icon: Icons.control_camera,
                  error: vm.state.name.error,
                  onChanged: (value) {
                    vm.changeName(value);
                  })),
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: DefaultTextfield(
                  initialValue: postArg.description,
                  label: 'Descripción',
                  icon: Icons.description,
                  error: vm.state.description.error,
                  onChanged: (value) {
                    vm.changeDescription(value);
                  })),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 15),
            child: const Text(
              'Categorías',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          PostsCategory(
              value: 'PC',
              groupValue: vm.state.category,
              onChanged: (value) {
                vm.changeRadioCategory(value);
              },
              imagePath: 'assets/img/icon_pc.png'),
          PostsCategory(
              value: 'XBOX',
              groupValue: vm.state.category,
              onChanged: (value) {
                vm.changeRadioCategory(value);
              },
              imagePath: 'assets/img/icon_xbox.png'),
          PostsCategory(
              value: 'PLAYSTATION',
              groupValue: vm.state.category,
              onChanged: (value) {
                vm.changeRadioCategory(value);
              },
              imagePath: 'assets/img/icon_ps4.png'),
          PostsCategory(
              value: 'NINTENDO',
              groupValue: vm.state.category,
              onChanged: (value) {
                vm.changeRadioCategory(value);
              },
              imagePath: 'assets/img/icon_nintendo.png'),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              vm.state.error,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: DefaultButton(
                  text: 'ACTUALIZAR POST',
                  onPressed: () {
                    vm.updatePost();
                  }))
        ],
      ),
    );
  }
}
