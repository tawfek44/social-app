import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login_screen/cubit/states.dart';
import 'package:social_app/shared/components/components/components.dart';

 class LoginCubit extends Cubit<LoginStates>{
   LoginCubit() : super(LoginInitialState());
  bool isObscure=true;
  static LoginCubit get(context) => BlocProvider.of(context);


  Future<void> userLogin({
  @required String email,
    @required String password
}) async {
    emit(LoginLoadingState());
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value){
      showToast(msg: 'login successfully', colorState: ToastStates.SUCCESS);
      emit(LoginSuccessState(value.user.uid));
    }).catchError((error){
      emit(LoginErrorState(error));
      showToast(msg: error.toString(), colorState: ToastStates.ERROR);
    });
  }
  void changeObsecure(){
    isObscure=!isObscure;
    emit(LoginChangeObscureState());
  }


}