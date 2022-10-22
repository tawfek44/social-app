import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/social_states.dart';

import '../../shared/components/components/components.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var textController=TextEditingController();
        var cubit = SocialCubit.get(context);
        var model = cubit.model;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar:defaultAppBar(
              context:context,
              title: "Create Post",
              actions: [
                TextButton(
                    onPressed: ()
                    {
                      if(SocialCubit.get(context).postImageFile!=null){
                        cubit.uploadPostImage(
                          text: textController.text
                        );
                      }else{
                        cubit.createNewPost(
                          text: textController.text,
                          dateTime: DateTime.now().toString(),
                        );
                      }
                    },
                    child: const Text('POST')
                )
              ]
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if(state is SocialCreateNewPostLoadingState || state is SocialCreateNewPostImageLoadingState)
                   const LinearProgressIndicator(),
                  if(state is SocialCreateNewPostLoadingState|| state is SocialCreateNewPostImageLoadingState)
                    const SizedBox(height: 10.0,),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(cubit.model.image),
                        radius: 25.0,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(model.name,style:const TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0,),
                  TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'What is on your mind ...',
                      border: InputBorder.none
                    ),

                  ),
                  if(SocialCubit.get(context).postImageFile!=null)
                    const SizedBox(height: 20.0,),
                  if(SocialCubit.get(context).postImageFile!=null)
                     Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children:[
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            height: 140.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                              image: DecorationImage(
                                image: FileImage(SocialCubit.get(context).postImageFile),
                                fit: BoxFit.cover,
                              ),

                            ),
                          ),
                        ),
                      ]
                  ),
                  if(SocialCubit.get(context).postImageFile!=null)
                    const SizedBox(height: 20.0,),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: (){
                              cubit.getPostImageFromGallery();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(IconlyBroken.image),
                                SizedBox(width: 5.0,),
                                Text('add photo')
                              ],
                            ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: (){},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('#tags')
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
