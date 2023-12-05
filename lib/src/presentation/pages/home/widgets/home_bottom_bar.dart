import 'package:flutter/material.dart';
import 'package:paw_rescue/src/presentation/pages/home/home_event.dart';
import 'package:paw_rescue/src/presentation/utils/base_color.dart';

class HomeBottomBar extends StatelessWidget {
  HomeEvent vm;
  BuildContext context;

  HomeBottomBar(this.context, this.vm);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: BACKGROUND_COLOR,
      currentIndex: vm.currentIndex,
      fixedColor: Colors.white,
      unselectedItemColor: Colors.grey[400],
      onTap: (index) {
        vm.currentIndex = index;
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.list, color: Colors.white), label: 'Publicaciones'),
        BottomNavigationBarItem(
            icon: Icon(Icons.list_alt, color: Colors.white), label: 'Mis Publicaciones'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white), label: 'Perfil')
      ],
    );
  }
}
