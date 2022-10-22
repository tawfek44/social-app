

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/cubit/social_states.dart';
import 'package:social_app/models/messageModel.dart';
import 'package:social_app/models/postModel.dart';
import 'package:social_app/shared/components/components/components.dart';

import '../../models/userModel.dart';
import '../../models/userModel.dart';
import '../../modules/add_post/add_post_Screen.dart';
import '../../modules/chats/chats_screen.dart';
import '../../modules/feed/new_feed_screen.dart';
import '../../modules/settings/setting_screen.dart';
import '../../modules/users/users_screen.dart';
import '../../shared/components/constans/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
class SocialCubit extends Cubit<SocialStates>{
  SocialCubit():super(SocialInitialState());
  static SocialCubit get(context) =>BlocProvider.of(context);
  userModel model;
  void getUserData(){
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.
    collection('users').
    doc(uId).
    get().then((value) {
      model=userModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error){
      emit(SocialGetUserErrorState(error));

    });
  }

  int currentIndex=0;
  List<Widget>screens=const [
    NewFeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen()
  ];
  List<String>titles=const [
   'News Feed',
    'Chats',
    '',
    'Users',
    'Settings'
  ];
  Future<void> changeBottomNav(int index)  {
    if(index==1)
      {
        getAllUsers();
      }
    if(index==2){
       emit(SocialNewPostState());
    }
    else {
      currentIndex=index;
      emit(ChangeBottomNavState());
    }
  }

  File image,cover,postImageFile;
  String imageProfile,coverProfile;
  var picker=ImagePicker();
  Future<void> getImageFromGallery({
  @required int mark
}) async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if(pickedImage !=null){

      if(mark==1){
        cover=File(pickedImage.path);
        emit(SocialCoverChangedSuccessState());
      }
      else
        {
          image=File(pickedImage.path);
          emit(SocialImageChangedSuccessState());
        }
    }
    else{
      if(mark==1){
        emit(SocialCoverChangedErrorState());
      }
      else
      {
        emit(SocialImageChangedErrorState());
      }
    }
  }

  void updateUserData({
    @required String name,
    @required String phone,
    @required String bio
  }){
    emit(UpdateUserDataLoadingState());
    userModel x=userModel
      (
      name: name,
      phone: phone,
      bio: bio,
      image: imageProfile??model.image,
      cover: coverProfile??model.cover,
      uId: uId,
      email: model.email
    );
    FirebaseFirestore
        .instance.collection('users')
        .doc(uId)
        .update(x.toMap()).then((value) {
          getUserData();
          emit(UpdateUserDataSuccessState());
       }).catchError((error){
      emit(UpdateUserDataErrorState());
      });
  }

  void updateUserImage({
    @required String name,
    @required String phone,
    @required String bio,
    }){
    emit(UpdateUserImageLoadingState());
      userModel x = userModel
        (
          name: name,
          phone: phone,
          bio: bio,
          image: model.image,
          cover: model.cover,
          uId: uId,
          email: model.email
      );
      FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(image.path).pathSegments.last}')
          .putFile(image).then((p0) {
            p0.ref.getDownloadURL().then((value) {
              imageProfile=value;
              updateUserData(
                  name: name,
                  phone: phone,
                  bio: bio,
              );
              emit(UpdateUserImageSuccessState());
            }).catchError((error){
              emit(UpdateUserImageErrorState());
            });
      }).catchError((error){

      });
  }

  void updateUserCover({
    @required String name,
    @required String phone,
    @required String bio,
  }){
    emit(UpdateUserCoverLoadingState());
    userModel x = userModel
      (
        name: name,
        phone: phone,
        bio: bio,
        image: model.image,
        cover: model.cover,
        uId: uId,
        email: model.email
    );
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(cover.path).pathSegments.last}')
        .putFile(cover).then((p0) {
      p0.ref.getDownloadURL().then((value) {
        coverProfile=value;
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
        );
        emit(UpdateUserCoverSuccessState());
      }).catchError((error){
        emit(UpdateUserCoverErrorState());
      });
    }).catchError((error){

    });
  }




  var pickerPost=ImagePicker();
  String postImagePath;
  Future<void> getPostImageFromGallery() async {
    final pickedImage = await pickerPost.pickImage(source: ImageSource.gallery);
    if(pickedImage !=null){
      postImageFile=File(pickedImage.path);
        emit(SocialGetNewPostImageFromGallerySuccessState());
    }
    else{
      emit(SocialGetNewPostImageFromGallerySuccessState());
    }
  }
  void uploadPostImage({
  @required String text
}) {
    emit(SocialCreateNewPostImageLoadingState());
     FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImageFile.path).pathSegments.last}')
        .putFile(postImageFile).then((p)
    {
      p.ref.getDownloadURL().then((value) {
        postImagePath=value;
        createNewPost(
          text: text,
          dateTime: DateTime.now().toString(),
          postImage: postImagePath,
        );
        emit(SocialCreateNewPostImageSuccessState());
      }).catchError((error){
        emit(SocialCreateNewPostImageErrorState());
      });
    }).catchError((error1){
      dynamic x=error1;
      showToast(msg: error1.toString(), colorState: ToastStates.ERROR);
    });
  }

  void createNewPost({
    String postImage,
    @required String text,
    @required String dateTime
}){
    emit(SocialCreateNewPostLoadingState());
    postModel x = postModel
      (
        image: postImage,
        text: text,
        dateTime: dateTime,
        uId: model.uId,
        name: model.name
    );
    FirebaseFirestore
        .instance.collection('posts')
        .add(x.toMap()).then((value) {
      emit(SocialCreateNewPostSuccessState());
    }).catchError((error){
      emit(SocialCreateNewPostErrorState());
    });
  }

  List<postModel> posts=[];
  List<String> postsId=[];
  List<int> postsLikes=[];
  void getPosts(){
    FirebaseFirestore
        .instance
        .collection('posts')
        .get().then((value){
          for (var element in value.docs) {
            element.reference.collection('likes').get().then((value) {
              postsLikes.add(value.docs.length);
              posts.add(postModel.fromJson(element.data()));
              postsId.add(element.id);
            });

          }
          emit(SocialGetPostsSuccessState());
    }).catchError((error){
      emit(SocialGetPostsErrorState());
    });
  }

  void addLike({
  @required String postId
}){
    FirebaseFirestore
        .instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model.uId)
        .set({
        'like':true
         }).then((value){

    }).catchError((error){

    });
  }
  List<userModel> users=[];
  Map<String,userModel>usersMap={};
  void getAllUsers(){

    emit(SocialGetAllUsersLoadingState());
    FirebaseFirestore
        .instance
        .collection('users')
        .get().then((value){
      users=[];
      usersMap.clear();
      for (var element in value.docs) {
        users.add(userModel.fromJson(element.data()));
        usersMap[userModel.fromJson(element.data()).uId]=userModel.fromJson(element.data());
      }
      emit(SocialGetAllUsersSuccessState());
    }).catchError((error){
      emit(SocialGetAllUsersErrorState());
    });
  }

  void sendMessage({
  @required String receiverId,
  @required String dateTime,
  @required String text,
}){
    MessageModel messageModel =MessageModel(
      text: text,
      dateTime: dateTime,
      receiverId: receiverId,
      senderId: model.uId,
    );
    FirebaseFirestore.instance
    .collection('users')
    .doc(model.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('messages')
    .add(messageModel.toMap())
    .then((value) {
      emit(SocialSendMessageSuccessState());
    })
    .catchError((error){
      emit(SocialSendMessageErrorState());
    });


    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error){
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages=[];
  void getMessage({
  @required String receiverId
}){
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages=[];
          for (var element in event.docs) {
            messages.add(MessageModel.fromJson(element.data()));
          }
          emit(SocialGetMessagesSuccessState());
    });

  }
}