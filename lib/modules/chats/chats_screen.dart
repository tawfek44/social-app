import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/social_states.dart';
import 'package:social_app/modules/chats/chat_details/chat_details.dart';
import 'package:social_app/shared/components/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder:(context,state){
        return ConditionalBuilder(
         condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (context)=>ListView.separated(
            physics: const BouncingScrollPhysics(),
             itemBuilder: (context,index)=>chatItem(context,index),
             separatorBuilder: (context,index)=> const Divider(height: 1.0,),
             itemCount: SocialCubit.get(context).users.length,
           ),
          fallback:  (context) => const Center(child: CircularProgressIndicator()),
        );
      } ,
    );
  }
  Widget chatItem(context,index) =>InkWell(
    onTap: (){
      navigateTo(context, ChatDetails(SocialCubit.get(context).users[index]));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(SocialCubit.get(context).users[index].image),
            radius: 25.0,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(SocialCubit.get(context).users[index].name,style: const TextStyle(fontWeight: FontWeight.bold),)
        ],
      ),
    ),
  );

}
