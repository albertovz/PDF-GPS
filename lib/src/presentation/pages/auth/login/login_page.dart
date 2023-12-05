import 'package:flutter/material.dart';
import 'package:paw_rescue/injection.dart';
import 'package:paw_rescue/main.dart';
import 'package:paw_rescue/src/domain/use_cases/auth/auth_usecases.dart';
import 'package:paw_rescue/src/domain/utils/resource.dart';
import 'package:paw_rescue/src/presentation/pages/auth/login/login_event.dart';
import 'package:paw_rescue/src/presentation/pages/auth/login/widgets/login_content.dart';
import 'package:paw_rescue/src/presentation/utils/base_color.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginEvent vm = Provider.of<LoginEvent>(context);

    return Scaffold(
        // backgroundColor: BACKGROUND_COLOR,

        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/img/login_bg.png'), // Change this to your image path
              fit: BoxFit.cover,
            ),
          ),
        ),
        StreamBuilder(
            stream: vm.response,
            builder: (context, snapshot) {
              final response = snapshot.data;
              if (response is Loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (response is Error) {
                final data = response as Error;
                Fluttertoast.showToast(
                    msg: 'Error: ${data.error}',
                    toastLength: Toast.LENGTH_LONG);
              } else if (response is Success) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyApp(locator<AuthUseCases>())),
                      (route) => false);
                });
              }
              return Container();
            }),
        LoginContent(vm)
      ],
    ));
  }
}
