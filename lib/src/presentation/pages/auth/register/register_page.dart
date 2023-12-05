import 'package:flutter/material.dart';
import 'package:paw_rescue/injection.dart';
import 'package:paw_rescue/main.dart';
import 'package:paw_rescue/src/domain/use_cases/auth/auth_usecases.dart';
import 'package:paw_rescue/src/domain/utils/resource.dart';
import 'package:paw_rescue/src/presentation/pages/auth/register/register_event.dart';
import 'package:paw_rescue/src/presentation/pages/auth/register/widgets/register_content.dart';
import 'package:paw_rescue/src/presentation/utils/base_color.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterEvent vm = Provider.of<RegisterEvent>(context);
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: Stack(
          children: [
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
                RegisterContent(vm)
          ],
        )
    );
  }
}
