import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:social_app/layout/cubit/social_cubit.dart';
import 'package:social_app/modules/edit_profile_screen/edit_profile_screen.dart';
import 'package:social_app/shared/components/components/components.dart';

import '../../layout/cubit/social_states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state) {},
      builder: (context,state){
        var model = SocialCubit.get(context).model;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 200.0,
                child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children:[
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          height: 140.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(model.cover),
                              fit: BoxFit.cover,
                            ),

                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 63.0,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(model.image),
                          radius: 60.0,
                        ),
                      ),
                    ]
                ),
              ),
              SizedBox(height: 10.0,),
              Text(
                model.name,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 18
                ),
              ),
              SizedBox(height: 5.0,),
              Text(
                model.bio,
                style: Theme.of(context).textTheme.caption,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0
                ),
                child: Row(
                  children: [

                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.bodyText1.copyWith(
                                  fontSize: 18
                              ),
                            ),
                            SizedBox(height: 5.0,),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '320',
                              style: Theme.of(context).textTheme.bodyText1.copyWith(
                                  fontSize: 18
                              ),
                            ),
                            SizedBox(height: 5.0,),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '10K',
                              style: Theme.of(context).textTheme.bodyText1.copyWith(
                                  fontSize: 18
                              ),
                            ),
                            SizedBox(height: 5.0,),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              '80',
                              style: Theme.of(context).textTheme.bodyText1.copyWith(
                                  fontSize: 18
                              ),
                            ),
                            SizedBox(height: 5.0,),
                            Text(
                              'Following',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    )

                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: (){},
                      child: const Text('Add Photos'),
                    ),

                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  OutlinedButton(
                      onPressed: (){
                        navigateTo(context, const EditProfileScreen());
                      },
                      child: const Icon(IconlyLight.edit,size: 16,)
                  ),

                ],
              )

            ],
          ),
        );
      },
    );
  }
}
