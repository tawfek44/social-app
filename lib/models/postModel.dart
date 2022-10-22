class postModel {
  String image,dateTime,text,name,uId;
  postModel({
    this.image,
    this.text,
    this.dateTime,
    this.name,
    this.uId
});
  postModel.fromJson(Map <String,dynamic> json){
    image=json['image'];
    text=json['text'];
    dateTime=json['dateTime'];
    name=json['name'];
    uId =json['uId'];
  }
  Map <String,dynamic> toMap(){
    return {
      'image':image,
      'text':text,
      'dateTime':dateTime,
      'name':name,
      'uId':uId,
    };
  }
}