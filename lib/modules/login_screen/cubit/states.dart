
abstract class LoginStates {}

class LoginInitialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final uId;

  LoginSuccessState(this.uId);
}
class LoginErrorState extends LoginStates{
  final error;
  LoginErrorState(this.error);
}
class LoginChangeObscureState extends LoginStates{}
