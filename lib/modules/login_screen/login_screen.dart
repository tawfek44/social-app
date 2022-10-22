import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/modules/login_screen/cubit/cubit.dart';
import 'package:social_app/modules/login_screen/cubit/states.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

import '../../shared/components/components/components.dart';
import '../register_screen/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
       listener: (context,state){
         if(state is LoginErrorState){
           showToast(msg: state.error, colorState: ToastStates.ERROR);
         }
         if(state is LoginSuccessState){
           CacheHelper.saveData(
               key: 'uId',
               value:state.uId
           ).then((value) {
             navigateAndFinish(context, const SocialLayout());
           });
         }
       },
        builder: (context,state){
         return Scaffold(
             backgroundColor: Colors.white,
             appBar: AppBar(
               backgroundColor: Colors.white,
               elevation: 0.0,
             ),
             body:Center(
               child: SingleChildScrollView(
                 child: Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Form(
                     key: formKey,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children:  [
                         const Text(
                           'LOGIN',
                           style: TextStyle(color: Colors.black,fontSize: 30.0,fontWeight: FontWeight.w600),
                         ),
                         const Text(
                           'login now to communicate with your friends !!',
                           style: TextStyle(color: Colors.grey,fontSize: 18.0),
                         ),
                         const SizedBox(height: 35.0,),
                         mainFormField(
                             label: 'Email Address',
                             prefixIcon: const Icon(Icons.email_outlined),
                             validate: (value){
                               if(value?.length == 0){
                                 return 'Make Sure Of Your Email';
                               }
                               return null;
                             },
                             controller: emailController
                             , type: TextInputType.emailAddress),
                         const SizedBox(height: 15.0,),
                         mainFormField(
                             label: 'Password',
                             prefixIcon: const Icon(Icons.lock_outline),
                             validate: (value){
                               if(value?.length == 0){
                                 return 'Make Sure Of Your Password';
                               }
                               return null;
                             },
                             controller: passwordController
                             , type: TextInputType.visiblePassword,
                             suffixIcon:  IconButton(
                               onPressed: () {
                                 LoginCubit.get(context).changeObsecure();
                               },
                               icon: LoginCubit.get(context).isObscure?const Icon(Icons.remove_red_eye_outlined):
                               const Icon(Icons.visibility_off),
                             ),
                             isObscure: LoginCubit.get(context).isObscure
                         ),
                         const SizedBox(height: 30.0,),
                         ConditionalBuilder
                           (condition: state is! LoginLoadingState,
                             builder: (context) => mainButton(
                               onPressed: (){
                                 if(formKey.currentState.validate()){
                                   LoginCubit.get(context).userLogin(
                                       email: emailController.text,
                                       password: passwordController.text);
                                 }
                               },
                               text:'LOGIN',
                             )
                             , fallback: (context) =>const Center(child: CircularProgressIndicator())
                         ),
                         const SizedBox(height: 15.0,),
                         Row(
                           children: [
                             const Text(
                                 'Don\'t have an account?'
                             ),
                             mainTextButton(
                                 text: 'REGISTER'
                                 , onp: (){
                                navigateTo(context, const RegisterScreen());
                             })
                           ],
                         )
                       ],
                     ),
                   ),
                 ),
               ),
             )
         );
        },
      ),
    );
  }
}
