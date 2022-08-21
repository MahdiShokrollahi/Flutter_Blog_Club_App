import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blogclub/carousel/carousel_slider.dart';
import 'package:flutter_blogclub/gen/assets.gen.dart';
import 'package:flutter_blogclub/data.dart';
import 'package:flutter_blogclub/gen/fonts.gen.dart';
import 'package:flutter_blogclub/screens/article.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final stories = AppDatabase.stories;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hi, Jonathan!',
                    style: themeData.textTheme.subtitle1,
                  ),
                  Assets.img.icons.notification.image(height: 24, width: 24)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 0, 24),
              child: Text(
                'Explore todays',
                style: themeData.textTheme.headline4,
              ),
            ),
            storyList(context, stories),
            SizedBox(height: 16),
            categoriesList(),
            postList(),
            SizedBox(height: 32)
          ],
        ),
      )),
    );
  }

  Widget storyList(BuildContext context, List<StoryData> stories) {
    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
        itemCount: stories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final story = stories[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  story.isViewed
                      ? profileImageViewed(story)
                      : profileImageNormal(story),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/img/icons/${story.iconFileName}',
                        height: 24,
                        width: 24,
                      ))
                ],
              ),
              SizedBox(height: 8),
              Text(story.name)
            ],
          );
        },
      ),
    );
  }

  Widget profileImageViewed(StoryData story) {
    return SizedBox(
      height: 68,
      width: 68,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(24),
        strokeWidth: 2,
        color: Color(0xff7B8BB2),
        dashPattern: [8, 3],
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
            ),
            child: ProfileImage(story),
          ),
        ),
      ),
    );
  }

  Widget profileImageNormal(StoryData story) {
    return Container(
      margin: EdgeInsets.fromLTRB(4, 2, 4, 0),
      height: 68,
      width: 68,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(colors: [
            Color(0xff376AED),
            Color(0xff49B0E2),
            Color(0xff9CECFB),
          ])),
      child: Container(
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(22)),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: ProfileImage(story),
        ),
      ),
    );
  }

  Widget ProfileImage(StoryData story) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset('assets/img/stories/${story.imageFileName}'));
  }
}

class postList extends StatelessWidget {
  postList({
    Key? key,
  }) : super(key: key);
  final posts = AppDatabase.posts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Latest News',
                style: Theme.of(context).textTheme.headline5,
              ),
              TextButton(onPressed: () {}, child: Text('More'))
            ],
          ),
        ),
        ListView.builder(
          itemCount: posts.length,
          itemExtent: 141,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final post = posts[index];
            return Post(post: post);
          },
        )
      ],
    );
  }
}

class Post extends StatelessWidget {
  const Post({
    Key? key,
    required this.post,
  }) : super(key: key);
  final PostData post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => ArticleScreen())),
      child: Container(
        margin: EdgeInsets.fromLTRB(32, 8, 32, 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Color(0x1a5282FF), blurRadius: 10)]),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/img/posts/small/${post.imageFileName}',
                width: 120,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.caption,
                      style: TextStyle(
                          fontFamily: FontFamily.avenir,
                          color: Color(0xff376AED)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      post.title,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          CupertinoIcons.hand_thumbsup,
                          size: 16,
                          color: Theme.of(context).textTheme.bodyText2!.color,
                        ),
                        SizedBox(width: 4),
                        Text(
                          post.likes,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(width: 16),
                        Icon(
                          CupertinoIcons.clock,
                          size: 16,
                          color: Theme.of(context).textTheme.bodyText2!.color,
                        ),
                        SizedBox(width: 4),
                        Text(
                          post.time,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              post.isBookmarked
                                  ? CupertinoIcons.bookmark_fill
                                  : CupertinoIcons.bookmark,
                              size: 16,
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class categoriesList extends StatelessWidget {
  categoriesList({
    Key? key,
  }) : super(key: key);
  final categories = AppDatabase.categories;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: categories.length,
        itemBuilder: (context, index, realindex) {
          return categoryItems(
            category: categories[realindex],
            left: realindex == 0 ? 32 : 8,
            right: realindex == categories.length - 1 ? 32 : 0,
          );
        },
        options: CarouselOptions(
            enableInfiniteScroll: false,
            scrollDirection: Axis.horizontal,
            scrollPhysics: BouncingScrollPhysics(),
            disableCenter: true,
            padEnds: false,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            enlargeCenterPage: true,
            initialPage: 0,
            viewportFraction: 0.8,
            aspectRatio: 1.2));
  }
}

class categoryItems extends StatelessWidget {
  categoryItems({
    Key? key,
    required this.category,
    required this.right,
    required this.left,
  }) : super(key: key);
  final Category category;
  final double right;
  final double left;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(left, 0, right, 0),
      child: Stack(
        children: [
          Positioned.fill(
            top: 100,
            right: 65,
            left: 65,
            bottom: 24,
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(blurRadius: 20, color: Color(0xaa0D253C))
              ]),
            ),
          ),
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32), color: Colors.blue),
              foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [Color(0xff0D253C), Colors.transparent])),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(
                  'assets/img/posts/large/${category.imageFileName}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 48,
            left: 32,
            child: Text(
              category.title,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .apply(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
