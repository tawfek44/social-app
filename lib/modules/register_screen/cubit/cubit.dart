import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/userModel.dart';
import 'package:social_app/modules/register_screen/cubit/states.dart';

 class RegisterCubit extends Cubit<RegisterStates>{
   RegisterCubit() : super(RegisterInitialState());
  bool isObscure=true;
  static RegisterCubit get(context) => BlocProvider.of(context);

  Future<void> userRegister({
  @required String name,
  @required String email,
  @required String password,
  @required String phone,
}) async {
    emit(RegisterLoadingState());
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
     ).then((value){
          createUser(
              name: name,
              email: email,
              phone: phone,
              uId: value.user.uid
          );
     }).catchError((error){
       emit(RegisterErrorState());
     });
  }

   Future<void> createUser({
     @required String name,
     @required String email,
     @required String phone,
     @required String uId,
     @required String image,
     @required String bio,
     @required String cover,
   }) async {
     userModel model= userModel(
       name: name,
       email: email,
       phone: phone,
       uId: uId,
       image: 'https://img.freepik.com/free-photo/close-up-hands-barista-make-latte-coffee-art-paint_1150-12161.jpg?w=740&t=st=1665148889~exp=1665149489~hmac=1577e4a974fac1755f4253f1f013d568e132d3ebafe2684f30e2e2974a64a3bc',
       bio: 'write your bio ...',
       cover:'https://img.freepik.com/free-photo/full-shot-travel-concept-with-landmarks_23-2149153258.jpg?3&w=900&t=st=1665152105~exp=1665152705~hmac=8edc712a39861611031760203faff77e7656d1df498da5a728aeda39859814d4'
     );
     FirebaseFirestore.instance.collection('users').
     doc(uId).
     set(model.toMap()).
     then((value){
       emit(CreateUserSuccessState());
     }).catchError((error){
       emit(CreateUserErrorState());
     });
   }
  void changeObsecure(){
    isObscure=!isObscure;
    emit(RegisterChangeObscureState());
  }

}