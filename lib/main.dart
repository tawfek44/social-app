import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/shared/components/constans/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/color.dart';

import 'modules/login_screen/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Widget startWidget;
  uId=CacheHelper.getData('uId');
  if(uId !=null){
    startWidget = const SocialLayout();
  }
  else {
    startWidget= const LoginScreen();
  }
  runApp(MyApp(startWidget));
}

class MyApp extends StatelessWidget {
  Widget widget;
  MyApp(this.widget);


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context)=>SocialCubit()..getUserData()..getPosts()
          )
        ]
        , child:
    MaterialApp(
        debugShowCheckedModeBanner: false,
        theme:ThemeData(
          primarySwatch: mainColor,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: mainColor,
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.grey,
            elevation: 20.0,

          ),
        ),
        themeMode:ThemeMode.light,
        home:widget
    )
    );

  }
}
