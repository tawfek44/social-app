import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/social_states.dart';
import 'package:social_app/modules/add_post/add_post_Screen.dart';
import 'package:social_app/shared/components/components/components.dart';
import 'package:social_app/shared/styles/Iconly-Broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){
        if(state is SocialNewPostState) {
          navigateTo(context, const NewPostScreen());
        }
      },
      builder: (context,state){
        var cubit =SocialCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            backgroundColor: Colors.white,
            elevation: 0.0,
            titleTextStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20.0),
            actions:[
              IconButton(onPressed: (){}, icon: const Icon(IconlyLight.notification),color: Colors.black,),
              IconButton(onPressed: (){}, icon: const Icon(IconlyLight.search),color: Colors.black,),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            currentIndex: cubit.currentIndex,
            items: const[
              BottomNavigationBarItem(icon:Icon(IconlyLight.home),label: 'Home'),
              BottomNavigationBarItem(icon:Icon(IconlyLight.chat),label: 'Chats'),
              BottomNavigationBarItem(icon:Icon(IconlyLight.paper_upload),label: 'Post'),
              BottomNavigationBarItem(icon:Icon(IconlyLight.location),label: 'Users'),
              BottomNavigationBarItem(icon:Icon(IconlyLight.setting),label: 'Settings'),
            ],
          ),
        );
      }
    );
  }
}
