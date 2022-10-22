class userModel {
  String name,email,phone,uId,image,bio,cover;
  userModel({this.name,this.phone,this.email,this.uId,this.image,this.bio,this.cover});
  userModel.fromJson(Map <String,dynamic> json){
    name=json['name'];
    phone=json['phone'];
    email=json['email'];
    uId=json['uId'];
    image=json['image'];
    bio=json['bio'];
    cover=json['cover'];
  }
  Map <String,dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'image':image,
      'bio':bio,
      'cover':cover
    };
  }
}