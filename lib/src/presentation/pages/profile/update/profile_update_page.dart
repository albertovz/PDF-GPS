import 'package:flutter/material.dart';
import 'package:paw_rescue/src/domain/models/user_data.dart';
import 'package:paw_rescue/src/presentation/pages/profile/update/profile_update_event.dart';
import 'package:paw_rescue/src/presentation/pages/profile/update/profile_update_response.dart';
import 'package:paw_rescue/src/presentation/pages/profile/update/widgets/profile_update_content.dart';
import 'package:paw_rescue/src/presentation/utils/base_color.dart';
import 'package:provider/provider.dart';

class ProfielUpdatePage extends StatelessWidget {
  const ProfielUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
  
    ProfileUpdateEvent vm = Provider.of<ProfileUpdateEvent>(context);
    UserData userDataArg = ModalRoute.of(context)?.settings.arguments as UserData;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ProfileUpdateResponse(context, vm);
    });
    

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: ProfileUpdateContent(vm, userDataArg),
    );
  }
}
