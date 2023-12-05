import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:paw_rescue/src/presentation/pages/auth/register/register_event.dart';
import 'package:paw_rescue/src/presentation/utils/base_color.dart';
import 'package:paw_rescue/src/presentation/widgets/default_button.dart';
import 'package:paw_rescue/src/presentation/widgets/default_textfield.dart';

class RegisterContent extends StatelessWidget {

  RegisterEvent vm;

  RegisterContent (this.vm);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.27,
              color: BASE_COLOR,
              child: Stack(
                alignment: Alignment.center,
                children: [
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/img/logo.png',
                        height: 100,
                        width: 150,
                      ),
                      const Text(
                        'Paw Rescue',
                        style:
                            TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, top: 15),
            child: const Text(
              'Continúa con tu',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: const Text(
              'Registro',
              style: TextStyle(
                  fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: DefaultTextfield(
                label: 'Nombre de usuario',
                icon: Icons.person_outline,
                error: vm.state.username.error,
                onChanged: (value) {
                  vm.changeUsername(value);
                }),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: DefaultTextfield(
                label: 'Correo electrónico',
                icon: Icons.email_outlined,
                error: vm.state.email.error,
                onChanged: (value) {
                  vm.changeEmail(value);
                }),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: DefaultTextfield(
                label: 'Contraseña',
                icon: Icons.lock_outline,
                obscureTexT: true,
                error: vm.state.password.error,
                onChanged: (value) {
                  vm.changePassword(value);
                }),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: DefaultTextfield(
                label: 'Confirmar contraseña',
                icon: Icons.lock_outline_rounded,
                obscureTexT: true,
                error: vm.state.confirmPassword.error,
                onChanged: (value) {
                  vm.changeConfirmPassword(value);
                }),
          ),
          Container(
            margin:
                const EdgeInsets.only(right: 15, left: 15, bottom: 40, top: 15),
            child: DefaultButton(text: 'Registrarse', onPressed: () {
              vm.register();
            }),
          )
        ],
      ),
    );
  }
}
