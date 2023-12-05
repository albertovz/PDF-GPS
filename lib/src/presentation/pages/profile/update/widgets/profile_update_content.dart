import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:paw_rescue/src/domain/models/user_data.dart';
import 'package:paw_rescue/src/presentation/pages/profile/update/profile_update_event.dart';
import 'package:paw_rescue/src/presentation/utils/show_select_image_dialog.dart';
import 'package:paw_rescue/src/presentation/widgets/default_button.dart';
import 'package:paw_rescue/src/presentation/widgets/default_textfield.dart';

class ProfileUpdateContent extends StatefulWidget {
  ProfileUpdateEvent vm;
  UserData userDataArg;

  ProfileUpdateContent(this.vm, this.userDataArg);

  @override
  State<ProfileUpdateContent> createState() => _ProfileUpdateContentState();
}

class _ProfileUpdateContentState extends State<ProfileUpdateContent> {
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.vm.loadData(widget.userDataArg);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: WaveClipperTwo(),
                child: Image.asset('assets/img/background.jpg',
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    colorBlendMode: BlendMode.darken,
                    color: Colors.black38),
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 60, bottom: 60),
                    width: double.infinity,
                    child: const Text(
                      'Perfil de usuario',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showSelectImageDialog(
                          context, widget.vm.pickImage, widget.vm.takePhoto);
                    },
                    child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white,
                        backgroundImage: widget.vm.imageFile != null
                            ? FileImage(widget.vm.imageFile!)
                            : widget.userDataArg.image.isNotEmpty
                                ? NetworkImage(widget.userDataArg.image)
                                : const AssetImage('assets/img/user_image.png')
                                    as ImageProvider),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 40, left: 20),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 30,
                    )),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
            child: DefaultTextfield(
                label: 'Nombre de usuario',
                initialValue: widget.vm.state.username.value,
                error: widget.vm.state.username.error,
                icon: Icons.person_2_outlined,
                onChanged: (value) {
                  widget.vm.changeUsername(value);
                }),
          ),
          Container(
              margin:
                  const EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 50),
              child: DefaultButton(
                text: 'Actualizar información',
                onPressed: () async {
                  // widget.vm.checkInternetConnection();
                  widget.vm.update();
                },
                icon: Icons.edit,
                color: Colors.green,
              )),
        ],
      ),
    );
  }
}
