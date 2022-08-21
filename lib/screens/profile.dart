import 'package:flutter/material.dart';
import 'package:flutter_blogclub/data.dart';
import 'package:flutter_blogclub/gen/assets.gen.dart';
import 'package:flutter_blogclub/screens/home_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final posts = AppDatabase.posts;
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                backgroundColor:
                    themeData.colorScheme.background.withOpacity(0),
                title: Text('Profile'),
                actions: [
                  Icon(Icons.more_horiz_rounded),
                  SizedBox(width: 16),
                ],
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(32, 0, 32, 64),
                    decoration: BoxDecoration(
                        color: themeData.colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 20,
                              color: themeData.colorScheme.onBackground
                                  .withOpacity(0.1))
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(24, 24, 24, 24),
                          child: Row(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Assets.img.stories.story8
                                      .image(width: 84, height: 84)),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('@joviedan'),
                                    SizedBox(height: 4),
                                    Text(
                                      'Jovi Daniel',
                                      style: themeData.textTheme.bodyText1!
                                          .copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'UX Desiner',
                                      style: themeData.textTheme.bodyText1!
                                          .apply(
                                              color: themeData
                                                  .colorScheme.primary),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                          child: Text('About me',
                              style: themeData.textTheme.headline6),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(32, 4, 32, 32),
                          child: Text(
                            'Madison Blackstone is a director of user experience design, with experience managing global teams.',
                            style: themeData.textTheme.bodyText1!
                                .copyWith(fontWeight: FontWeight.w200),
                          ),
                        ),
                        const SizedBox(height: 24)
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 32,
                    right: 96,
                    left: 96,
                    child: Container(
                      height: 32,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            blurRadius: 30,
                            color: themeData.colorScheme.onBackground
                                .withOpacity(0.8))
                      ]),
                    ),
                  ),
                  Positioned(
                    bottom: 32,
                    right: 64,
                    left: 64,
                    child: Container(
                      height: 68,
                      decoration: BoxDecoration(
                          color: themeData.colorScheme.primary,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff2151CD),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '52',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: themeData.colorScheme.onPrimary),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Post',
                                    style: themeData.textTheme.bodyText1!
                                        .copyWith(
                                            color:
                                                themeData.colorScheme.onPrimary,
                                            fontWeight: FontWeight.w200),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '250',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: themeData.colorScheme.onPrimary),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Following',
                                  style: themeData.textTheme.bodyText1!
                                      .copyWith(
                                          color:
                                              themeData.colorScheme.onPrimary,
                                          fontWeight: FontWeight.w200),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '4.5k',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: themeData.colorScheme.onPrimary),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Followers',
                                  style: themeData.textTheme.bodyText1!
                                      .copyWith(
                                          color:
                                              themeData.colorScheme.onPrimary,
                                          fontWeight: FontWeight.w200),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    color: themeData.colorScheme.surface,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Text(
                            'My Posts',
                            style: themeData.textTheme.headline6,
                          )),
                          IconButton(
                              onPressed: () {},
                              icon: Assets.img.icons.grid.image()),
                          IconButton(
                              onPressed: () {},
                              icon: Assets.img.icons.table.image())
                        ],
                      ),
                    ),
                    for (var i = 0; i < posts.length; i++) Post(post: posts[i]),
                    SizedBox(height: 16)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
