abstract class SocialStates {}

class SocialInitialState extends SocialStates{}
class SocialGetUserLoadingState extends SocialStates{}
class SocialGetUserSuccessState extends SocialStates{}
class SocialGetUserErrorState extends SocialStates{
  final error;
  SocialGetUserErrorState(this.error);
}
class ChangeBottomNavState extends SocialStates{}
class SocialNewPostState extends SocialStates{}

class SocialImageChangedSuccessState extends SocialStates{}
class SocialImageChangedErrorState extends SocialStates{}

class SocialCoverChangedSuccessState extends SocialStates{}
class SocialCoverChangedErrorState extends SocialStates{}

class UpdateUserDataLoadingState extends SocialStates{}
class UpdateUserDataSuccessState extends SocialStates{}
class UpdateUserDataErrorState extends SocialStates{}

class UpdateUserImageLoadingState extends SocialStates{}
class UpdateUserImageSuccessState extends SocialStates{}
class UpdateUserImageErrorState extends SocialStates{}

class UpdateUserCoverLoadingState extends SocialStates{}
class UpdateUserCoverSuccessState extends SocialStates{}
class UpdateUserCoverErrorState extends SocialStates{}

class SocialCreateNewPostLoadingState extends SocialStates{}
class SocialCreateNewPostSuccessState extends SocialStates{}
class SocialCreateNewPostErrorState extends SocialStates{}

class SocialCreateNewPostImageLoadingState extends SocialStates{}
class SocialCreateNewPostImageSuccessState extends SocialStates{}
class SocialCreateNewPostImageErrorState extends SocialStates{}

class SocialGetNewPostImageFromGallerySuccessState extends SocialStates{}
class SocialGetNewPostImageFromGalleryErrorState extends SocialStates{}

class SocialGetPostsSuccessState extends SocialStates{}
class SocialGetPostsErrorState extends SocialStates{}

class SocialGetAllUsersLoadingState extends SocialStates{}
class SocialGetAllUsersSuccessState extends SocialStates{}
class SocialGetAllUsersErrorState extends SocialStates{}


class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{}


class SocialGetMessagesSuccessState extends SocialStates{}
class SocialGetMessagesErrorState extends SocialStates{}