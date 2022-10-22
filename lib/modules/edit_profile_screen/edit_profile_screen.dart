import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/layout/cubit/social_states.dart';

import '../../shared/components/components/components.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController=TextEditingController();
    var bioController=TextEditingController();
    var phoneController=TextEditingController();
    return BlocConsumer<SocialCubit,SocialStates>(
     listener: (context,state){},
     builder: (context,state){
       var model =SocialCubit.get(context).model;
       var profileImage=SocialCubit.get(context).image;
       var profileCover=SocialCubit.get(context).cover;
       nameController.text=model.name;
       bioController.text=model.bio;
       phoneController.text=model.phone;
       return  Scaffold(
         backgroundColor: Colors.white,
         appBar:defaultAppBar(
           context:context,
           title: "Edit Profile",
           actions:
           [
             TextButton(
               onPressed: (){
                 SocialCubit.get(context).updateUserData(
                     name: nameController.text,
                     phone: phoneController.text,
                     bio: bioController.text
                 );
               },
               child: const Text("UPDATE"),
             ),
             const SizedBox(width: 15.0,)
           ],
         ),
         body: SingleChildScrollView(
           child: Column(
             children: [
               if(state is UpdateUserDataLoadingState
                   || state is UpdateUserImageLoadingState
                   || state is UpdateUserCoverLoadingState
               )
                 const LinearProgressIndicator(),
               if(state is UpdateUserDataLoadingState
                   || state is UpdateUserImageLoadingState
                   || state is UpdateUserCoverLoadingState
               )
                 const SizedBox(height: 10.0,),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                   height: 200.0,
                   child: Stack(
                       alignment: AlignmentDirectional.bottomCenter,
                       children:[
                         Align(
                           alignment: AlignmentDirectional.topCenter,
                           child: Stack(
                             alignment: AlignmentDirectional.topEnd,
                             children: [
                               Container(
                                 height: 140.0,
                                 width: double.infinity,
                                 decoration: BoxDecoration(
                                   borderRadius:const  BorderRadius.only(
                                     topLeft:  Radius.circular(4.0),
                                     topRight: Radius.circular(4.0),
                                   ),
                                   image: DecorationImage(
                                     image:  SocialCubit.get(context).cover == null?
                                     NetworkImage(model.cover):FileImage(profileCover),
                                     fit: BoxFit.cover,
                                   ),

                                 ),
                               ),
                               IconButton(
                                   onPressed: (){
                                     SocialCubit.get(context).getImageFromGallery(mark: 1).then((value) {
                                       SocialCubit.get(context).updateUserCover(
                                           name: nameController.text,
                                           phone: phoneController.text,
                                           bio: bioController.text);
                                     });
                                   },
                                   icon: const CircleAvatar(
                                     radius: 20.0,
                                     child: Icon(IconlyLight.camera,size: 16,),
                                   ),

                               )
                             ],
                           ),
                         ),
                         CircleAvatar(
                           radius: 63.0,
                           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                           child: Stack(
                             alignment: AlignmentDirectional.bottomEnd,
                             children: [
                               CircleAvatar(
                                 backgroundImage:SocialCubit.get(context).image == null?
                                     NetworkImage(model.image):FileImage(profileImage),
                                 radius: 60.0,
                               ),
                               IconButton(
                                 onPressed: (){
                                   SocialCubit.get(context).getImageFromGallery(mark: 2).then((value) {
                                     SocialCubit.get(context).updateUserImage(
                                         name: nameController.text,
                                         phone: phoneController.text,
                                         bio: bioController.text);
                                   });
                                 },
                                 icon: const CircleAvatar(
                                   radius: 20.0,
                                   child: Icon(IconlyLight.camera,size: 16,),
                                 ),

                               )
                             ],
                           ),
                         ),
                       ]
                   ),
                 ),
               ),
               const SizedBox(height: 10.0,),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: mainFormField(
                     label: 'Name',
                     prefixIcon: const Icon(IconlyLight.user),
                     validate: (String value){
                       if(value.isEmpty){
                         return 'Check Your Name Please ..!';
                       }
                       return null;
                     },
                     controller: nameController,
                     type: TextInputType.name,
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: mainFormField(
                   label: 'Bio',
                   prefixIcon: const Icon(IconlyLight.info_circle),
                   validate: (String value){
                     if(value.isEmpty){
                       return 'Check Your Bio Please ..!';
                     }
                     return null;
                   },
                   controller: bioController,
                   type: TextInputType.name,
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: mainFormField(
                   label: 'Phone',
                   prefixIcon: const Icon(IconlyLight.call),
                   validate: (String value){
                     if(value.isEmpty){
                       return 'Check Your Phone Number Please ..!';
                     }
                     return null;
                   },
                   controller: phoneController,
                   type: TextInputType.name,
                 ),
               )
             ],
           ),
         ),
       );
     },
    );
  }
}
