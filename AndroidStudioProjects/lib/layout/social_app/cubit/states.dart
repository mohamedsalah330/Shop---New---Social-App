abstract class SocialStates {}

class SocialInitialStates extends SocialStates{}

class SocialGetUsersLoadingState extends SocialStates{}

class SocialGetUsersSuccessState extends SocialStates{}

class SocialGetUsersErrorState extends SocialStates
{
  final String error;

  SocialGetUsersErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}