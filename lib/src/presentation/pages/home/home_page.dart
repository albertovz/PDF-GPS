import 'package:flutter/material.dart';
import 'package:paw_rescue/src/presentation/pages/home/home_event.dart';
import 'package:paw_rescue/src/presentation/pages/home/widgets/home_bottom_bar.dart';
import 'package:paw_rescue/src/presentation/pages/posts/list/posts_list_page.dart';
import 'package:paw_rescue/src/presentation/pages/posts/my_list/posts_my_list_page.dart';
import 'package:paw_rescue/src/presentation/pages/profile/info/profile_info_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeEvent vm = Provider.of<HomeEvent>(context);
    final currentTap = [
      const PostListPage(),
      const PostsMyListPage(),
      ProfileInfoPage()
    ];

    return Scaffold(
      // body: Center(
      //     child: DefaultButton(
      //   text: 'Cerrar sesión',
      //   onPressed: () async {
      //     await vm.logout();
      //     Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
      //   },
      // )),
      body: currentTap[vm.currentIndex],
      bottomNavigationBar: HomeBottomBar(context, vm),
    );
  }
}
