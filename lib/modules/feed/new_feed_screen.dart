
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/social_states.dart';
import 'package:social_app/models/postModel.dart';
import 'package:social_app/models/userModel.dart';

class NewFeedsScreen extends StatelessWidget {
  const NewFeedsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty,
          builder: (context) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index) => buildPostItem(SocialCubit.get(context).posts[index],context,index),
                      separatorBuilder: (context,index) =>const SizedBox(height: 8.0,),
                      itemCount: SocialCubit.get(context).posts.length
                  )

                ],
              ),
            );
          },
          fallback: (context) => const Center(child: CircularProgressIndicator()),

        );
      },
    );
  }

  Widget buildPostItem(postModel postModel,context,index)=> Card(
    elevation: 5.0,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: const EdgeInsets.symmetric(
        horizontal: 8.0
    ),

    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(SocialCubit.get(context).usersMap[postModel.uId].image),
                radius: 25.0,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(postModel.name,style: const TextStyle(fontWeight: FontWeight.bold),),
                    Text(postModel.dateTime,
                        style: Theme.of(context).textTheme.caption)
                  ],
                ),
              ),
              IconButton(onPressed: (){}, icon: const Icon(IconlyLight.more_circle)),
            ],
          ),
          const SizedBox(height: 10,),
          const Divider(
            height: 2.0,
          ),
          const SizedBox(height: 10,),
           Text(
            postModel.text
          ),
          const SizedBox(height: 10,),
          if(postModel.image!=null)
            Container(
            height: 140.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              image: DecorationImage(
                image: NetworkImage(postModel.image),
                fit: BoxFit.cover,
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 10.0
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0
                      ),
                      child: Row(
                        children: [
                          const Icon(IconlyLight.heart,color: Colors.red,),
                          Text(SocialCubit.get(context).postsLikes[index].toString(),style: Theme.of(context).textTheme.caption,)
                        ],
                      ),
                    ),
                    onTap: (){

                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(IconlyLight.chat,color: Colors.amber,),
                          Text('0 comment',style: Theme.of(context).textTheme.caption,)
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                )
              ],
            ),
          ),
          const Divider(height: 1.0,),
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0
            ),
            child: Row(
              children: [

                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(SocialCubit.get(context).model.image),
                          radius: 18.0,
                        ),
                        const SizedBox(width: 10,),
                        Text(
                          'write a comment ...',
                          style: Theme.of(context).textTheme.caption.copyWith(
                              fontSize: 13
                          ),
                        )
                      ],
                    ),
                    onTap: (){},
                  ),
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        IconlyLight.heart,
                        color: Colors.red ,
                      ),
                      const SizedBox(width: 5,),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption.copyWith(
                            fontSize: 13
                        ),
                      )
                    ],
                  ),
                  onTap: (){
                    SocialCubit.get(context).addLike(postId: SocialCubit.get(context).postsId[index]);
                  },
                )
              ],
            ),
          )
        ],
      ),
    ),
  );

}
