import 'package:flutter/material.dart';
import 'package:stella/ui/books.dart';
import 'package:stella/ui/common.dart';
import 'package:stella/ui/courses.dart';
import 'package:stella/ui/neumorph.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return StellaPageScaffold(
      background: _background(),
      body: Column(
        children: [
          SectionTitle(title: 'Recent'),
          _recentBlock(),
          SectionTitle(
            title: 'Courses',
            onTap: () {},
          ),
          _coursesBlock(),
          SectionTitle(
            title: 'Books',
            onTap: () {},
          ),
          _booksBlock(),
          Container(height: 400.0),
        ],
        mainAxisSize: MainAxisSize.min,
      ),
      topExtent: 150.0,
    );
  }

  Widget _background() {
    var avatar = NeuContainer(
      // avatar
      child: Container(
        child: Image.asset('assets/avatar.png'),
        width: 90.0,
        height: 90.0,
      ),
      elevation: 12.0,
      radius: 18.0,
    );
    var username = Text(
      'Yeltsa Kcir',
      style: Theme.of(context).textTheme.headline4?.copyWith(
            color: StellaTheme.of(context).foregroundColor,
          ),
      textScaleFactor: 0.86,
    );
    var signature = Text(
      'Currently learning Data Structures and Algorithms.',
      style: Theme.of(context).textTheme.headline6?.copyWith(
            color: StellaTheme.of(context).hintColor,
          ),
      textScaleFactor: 0.7,
      overflow: TextOverflow.ellipsis,
    );
    var progress = NeuProgressBar(
      color: Colors.blue[300]!,
      glowColor: Colors.lightBlueAccent,
      percentage: 0.55,
    );
    return Container(
      // add vertical padding
      child: Row(
        children: [
          avatar,
          Container(width: StellaTheme.of(context).tilePadding),
          Expanded(
            child: Container(
              child: Column(
                children: [
                  username,
                  signature,
                  Expanded(child: SizedBox()),
                  progress,
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              height: 90.0,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      padding: StellaTheme.of(context).padding,
    );
  }

  Widget _recentBlock() {
    return Row(
      children: [
        SizedBox(width: StellaTheme.of(context).padding.left),
        Expanded(
          // horizontal fit
          child: NeuButton(
            child: Column(
              children: [
                Container(
                  child: Text(
                    '6.851 Advanced Data Structures (Fall 2021)',
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                  ),
                  padding: EdgeInsets.only(
                    top: 12.0,
                    bottom: 8.0,
                    left: 12.0,
                    right: 12.0,
                  ),
                ),
                ClipRRect(
                  child: Image.asset(
                    'assets/courses/6-851.jpg',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    height: 200.0,
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            elevation: 12.0,
            shape: NeuShape.Convex,
          ),
        ),
        SizedBox(width: StellaTheme.of(context).padding.right),
      ],
    );
  }

  Widget _coursesBlock() {
    StellaThemeData sTheme = StellaTheme.of(context);
    List<Widget> row = [
      Expanded(
        child: SizedBox(
          width: sTheme.padding.left - sTheme.tilePadding / 2,
        ),
        flex: 0,
      ),
    ];
    for (Course course in getAllCourses()) row.add(CourseTile(course: course));
    row.add(SizedBox(width: sTheme.padding.right - sTheme.tilePadding / 2));
    return ConstrainedBox(
      child: ListView(
        children: row,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
      ),
      constraints:
          BoxConstraints.tight(Size(MediaQuery.of(context).size.width, 180)),
    );
  }

  Widget _booksBlock() {
    StellaThemeData sTheme = StellaTheme.of(context);
    List<Widget> row = [
      Expanded(
        child: SizedBox(
          width: sTheme.padding.left - sTheme.tilePadding / 2,
        ),
        flex: 0,
      ),
    ];
    for (Book book in getAllBooks()) row.add(BookTile(book: book));
    row.add(SizedBox(width: sTheme.padding.right - sTheme.tilePadding / 2));
    return ConstrainedBox(
      child: ListView(
        children: row,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
      ),
      constraints:
          BoxConstraints.tight(Size(MediaQuery.of(context).size.width, 215)),
    );
  }
}
