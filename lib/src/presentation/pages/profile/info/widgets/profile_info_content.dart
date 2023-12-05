import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:paw_rescue/injection.dart';
import 'package:paw_rescue/main.dart';
import 'package:paw_rescue/src/domain/models/user_data.dart';
import 'package:paw_rescue/src/domain/use_cases/auth/auth_usecases.dart';
import 'package:paw_rescue/src/presentation/pages/profile/info/profile_info_event.dart';
import 'package:paw_rescue/src/presentation/widgets/default_button.dart';

class ProfileInfoContent extends StatelessWidget {
  UserData userData;
  ProfileInfoEvent vm;

  ProfileInfoContent(this.vm, this.userData);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white,
                  backgroundImage: userData.image.isNotEmpty
                      ? NetworkImage(userData.image)
                      : const AssetImage('assets/img/user_image.png')
                          as ImageProvider,
                )
              ],
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 40),
          child: Text(
            userData.username,
            style: const TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Text(
            userData.email,
            style: const TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
        const Spacer(),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: DefaultButton(
              onPressed: () {
                Navigator.pushNamed(context, 'profile/update',
                    arguments: userData);
              },
              text: 'Editar datos',
              icon: Icons.edit,
              color: Colors.white,
            )),
        Container(
            margin:
                const EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 50),
            child: DefaultButton(
              text: 'Cerrar sesión',
              onPressed: () async {
                await vm.logout();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyApp(locator<AuthUseCases>())),
                    (route) => false);
              },
              icon: Icons.power_settings_new,
              color: Colors.red,
            )),
      ],
    );
  }
}
