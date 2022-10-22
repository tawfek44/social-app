import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/social_states.dart';
import 'package:social_app/models/messageModel.dart';
import 'package:social_app/shared/styles/Iconly-Broken.dart';

import '../../../models/userModel.dart';
import '../../../shared/styles/color.dart';

class ChatDetails extends StatelessWidget {
  userModel model;
  var messageController=TextEditingController();
   ChatDetails( this.model);

  @override
  Widget build(BuildContext context) {

      return Builder(
        builder: (context){
          SocialCubit.get(context).getMessage(receiverId: model.uId);
          return BlocConsumer<SocialCubit,SocialStates>(
            listener: (context,state) {},
            builder: (context,state){
              return  Scaffold(
                appBar: AppBar(
                  titleSpacing: 0.0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(model.image),
                      ),
                      const SizedBox(width: 10.0,),
                      Text(
                          model.name
                      )
                    ],
                  ),
                ),
                body:Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      if(SocialCubit.get(context).messages.isNotEmpty)
                        Expanded(
                        child: ListView.separated(
                          itemBuilder: (context,index){
                            var message = SocialCubit.get(context).messages[index];
                            if(message.senderId == SocialCubit.get(context).model.uId){
                              return buildMyMessage(message: message);
                            }
                            return  buildMessage(message: message);
                          },
                          separatorBuilder: (context,index)=>const SizedBox(height: 5.0,),
                          itemCount: SocialCubit.get(context).messages.length,
                        ),
                      ),
                      if(SocialCubit.get(context).messages.isEmpty)
                        const Spacer(),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey[300],
                                width: 1.0
                            ),
                            borderRadius: BorderRadiusDirectional.circular(15.0)
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration:  const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'type your message here ...'
                                  ),
                                ),
                              ),),

                            Container(
                              color: mainColor,
                              height: 50.0,
                              child: MaterialButton(
                                onPressed: (){
                                  SocialCubit.get(context).sendMessage(
                                    receiverId: model.uId,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );
                                  messageController.text='';
                                },
                                minWidth: 1.0,
                                child: const Icon(
                                  IconlyBroken.send,
                                  size: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              );
            },
          );
        },
      );
  }
  Widget buildMessage({@required MessageModel message}) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          )
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 7.0,
          horizontal: 15.0
      ),
      child: Text(message.text),
    ),
  );
  Widget buildMyMessage({@required MessageModel message}) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
          color: mainColor.withOpacity(.2),
          borderRadius: const BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          )
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 7.0,
          horizontal: 15.0
      ),
      child: Text(message.text),
    ),
  );
}
