
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';

import '../../styles/color.dart';

Widget mainFormField( {
  @required String label,
  @required Widget prefixIcon,
  @required FormFieldValidator<String> validate,
  @required TextEditingController controller,
  @required TextInputType type,
  Widget suffixIcon,
  bool isObscure=false,
  Function onChange
}) => TextFormField(
  decoration: InputDecoration(
    label:  Text(label),
    border: const OutlineInputBorder(),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    ),
  validator: validate,
  controller: controller,
  keyboardType: type,
  obscureText: isObscure,
  onChanged: onChange,
);

Widget mainButton({
  @required final Function onPressed,
  @required String text
}) =>MaterialButton(
    onPressed: onPressed,
    color:mainColor,
    minWidth: double.infinity,
    height: 50.0,
    child: Text(text,
      style: const TextStyle(fontSize: 20.0,color: Colors.white),
    ),
);

Widget mainTextButton ({
  @required String text,
  @required Function onp
})=>TextButton(onPressed: onp, child: Text(text));
void navigateTo(context,screen)=>
    Navigator.push(context, MaterialPageRoute(builder: (context)=> screen));
void navigateAndFinish(context,screen) =>
    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=> screen),
        (Route<dynamic> route) => false,
);

void showToast ({@required String msg,@required ToastStates colorState}) => Fluttertoast.showToast(
  msg: msg,
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: chooseToastColor(colorState),
  textColor: Colors.white,
  fontSize: 16.0
);

enum ToastStates {SUCCESS,ERROR,WARNNING}

Color chooseToastColor(colorState){
  if(colorState==ToastStates.SUCCESS){
    return Colors.green;
  }
  if(colorState==ToastStates.ERROR){
    return Colors.red;
  }
  if(colorState==ToastStates.WARNNING){
    return Colors.amber;
  }
}
Widget defaultAppBar({
  @required BuildContext context,
  List<Widget>actions,
  String title
}) => AppBar(
  title:  Text(title,style: const TextStyle(color: Colors.black)),
  actions: actions,
  leading: IconButton(
    icon: const Icon(IconlyLight.arrow_left_2),
    onPressed: () {
      Navigator.pop(context);
  },color: Colors.black,
  ),
  backgroundColor: Colors.white,
  elevation: 0.0,
  titleSpacing: 0.0,
);



