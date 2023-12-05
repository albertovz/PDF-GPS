import 'package:flutter/material.dart';
import 'package:paw_rescue/injection.dart';
import 'package:paw_rescue/src/domain/use_cases/auth/auth_usecases.dart';
import 'package:paw_rescue/src/domain/use_cases/posts/posts_usecases.dart';
import 'package:paw_rescue/src/domain/use_cases/users/users_usecases.dart';
import 'package:paw_rescue/src/presentation/pages/auth/login/login_event.dart';
import 'package:paw_rescue/src/presentation/pages/auth/login/login_page.dart';
import 'package:paw_rescue/src/presentation/pages/auth/register/register_event.dart';
import 'package:paw_rescue/src/presentation/pages/auth/register/register_page.dart';
import 'package:paw_rescue/src/presentation/pages/home/home_event.dart';
import 'package:paw_rescue/src/presentation/pages/home/home_page.dart';
import 'package:paw_rescue/src/presentation/pages/posts/create/post_create_event.dart';
import 'package:paw_rescue/src/presentation/pages/posts/create/posts_create_page.dart';
import 'package:paw_rescue/src/presentation/pages/posts/detail/post_detail_page.dart';
import 'package:paw_rescue/src/presentation/pages/posts/detail/posts_detail_event.dart';
import 'package:paw_rescue/src/presentation/pages/posts/list/posts_list_event.dart';
import 'package:paw_rescue/src/presentation/pages/posts/my_list/posts_mylist_event.dart';
import 'package:paw_rescue/src/presentation/pages/posts/update/posts_update_event.dart';
import 'package:paw_rescue/src/presentation/pages/posts/update/posts_update_page.dart';
import 'package:paw_rescue/src/presentation/pages/profile/info/profile_info_event.dart';
import 'package:paw_rescue/src/presentation/pages/profile/update/profile_update_event.dart';
import 'package:paw_rescue/src/presentation/pages/profile/update/profile_update_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(MyApp(locator<AuthUseCases>()));
}

class MyApp extends StatelessWidget {

  AuthUseCases _authUseCases;

  MyApp(this._authUseCases);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String idSession = _authUseCases.getUser.userSession?.uid ?? '';
    return MultiProvider(
      key: Key(idSession),
      providers: [
        ChangeNotifierProvider(create: (context) => LoginEvent(locator<AuthUseCases>())),
        ChangeNotifierProvider(create: (context) => RegisterEvent(locator<AuthUseCases>())),
        ChangeNotifierProvider(create: (context) => HomeEvent(locator<AuthUseCases>())),
        ChangeNotifierProvider(create: (context) => ProfileInfoEvent(locator<UsersUseCase>(), locator<AuthUseCases>())),
        ChangeNotifierProvider(create: (context) => ProfileUpdateEvent(locator<UsersUseCase>())),
        ChangeNotifierProvider(create: (context) => PostsCreateEvent(locator<AuthUseCases>(), locator<PostsUseCases>())),
        ChangeNotifierProvider(create: (context) => PostsListEvent(locator<AuthUseCases>(), locator<PostsUseCases>(), locator<UsersUseCase>())),
        ChangeNotifierProvider(create: (context) => PostsDetailEvent(locator<PostsUseCases>(), locator<UsersUseCase>())),
        ChangeNotifierProvider(create: (context) => PostsDetailEvent(locator<PostsUseCases>(), locator<UsersUseCase>())),
        ChangeNotifierProvider(create: (context) => PostsMyListEvent(locator<AuthUseCases>(), locator<PostsUseCases>())),
        ChangeNotifierProvider(create: (context) => PostsUpdateEvent(locator<AuthUseCases>(), locator<PostsUseCases>())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: idSession.isEmpty ? 'login' : 'home',
        routes: {
          'login' : (BuildContext context) => LoginPage(),
          'register': (BuildContext context) => const RegisterPage(),
          'home': (BuildContext context) => const HomePage(),
          'profile/update': (BuildContext context) => const ProfielUpdatePage(),
          'posts/create': (BuildContext context) => PostsCreatePage(),
          'posts/detail': (BuildContext context) => PostsDetailPage(),
          'posts/update': (BuildContext context) => const PostsUpdatePage(),
        },
      ),
    );
  }
}