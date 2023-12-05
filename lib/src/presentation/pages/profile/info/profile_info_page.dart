import 'package:flutter/material.dart';
import 'package:paw_rescue/src/domain/models/user_data.dart';
import 'package:paw_rescue/src/domain/utils/resource.dart';
import 'package:paw_rescue/src/presentation/pages/profile/info/profile_info_event.dart';
import 'package:paw_rescue/src/presentation/pages/profile/info/widgets/profile_info_content.dart';
import 'package:paw_rescue/src/presentation/utils/base_color.dart';
import 'package:provider/provider.dart';

class ProfileInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProfileInfoEvent vm = Provider.of<ProfileInfoEvent>(context);

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      // body: ProfileContent()
      body: StreamBuilder(
          stream: vm.getUserById(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: Text('No hay información')
                );
              }
            final response = snapshot.data;
            if (response is Error) {
              final data = response as Error;
              return Center(
                child: Text(
                    'Error: ${data.error}'),
              );
            }
            final success = response as Success<UserData>;
            return ProfileInfoContent(vm, success.data);
          })),
    );
  }
}
