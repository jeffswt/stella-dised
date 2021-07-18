import 'package:flutter/material.dart';
import 'package:stella/ui/common.dart';
import 'package:stella/ui/neumorph.dart';

class DiscussBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StellaThemeData sTheme = StellaThemeData.defaultLight();
    Widget title = Container(
      child: Text(
        'Discussion Board',
        style: Theme.of(context).textTheme.headline6,
        textScaleFactor: 1.0,
      ),
      padding: EdgeInsets.only(
        top: 12.0,
        bottom: 12.0,
        left: 12.0,
      ),
    );
    return Container(
      child: NeuContainer(
        child: Column(
          children: <Widget>[
            title,
          ] + _topics(context),
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: sTheme.padding.left,
      ),
    );
  }

  List<Widget> _topics(BuildContext context) {
    List<String> rawTopics = [
      'All topics',
      'Retroactive: How are these arrays stored?',
      'Debugging: segfault irregularly help'
      'Retroactive: Why are they working at O(log n)?',
      'Segment tree: anyone solve this prob pls',
      'Linked list: linked list in rust?',
      'Retroactive: How are these arrays stored?',
      'Debugging: segfault irregularly help'
      'Retroactive: Why are they working at O(log n)?',
      'Segment tree: anyone solve this prob pls',
      'Linked list: linked list in rust?',
      'Retroactive: How are these arrays stored?',
      'Debugging: segfault irregularly help'
      'Retroactive: Why are they working at O(log n)?',
      'Segment tree: anyone solve this prob pls',
      'Linked list: linked list in rust?',
    ];
    return rawTopics.map((s) => _topic(context, s)).toList();
  }

  Widget _topic(BuildContext context, String title) {
    return Container(
      child: NeuButton(
        child: Container(
          child: Text(title),
          padding: EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width,
        ),
        radius: 8.0,
        elevation: 4.0,
      ),
      padding: EdgeInsets.only(bottom: 12.0, left: 12.0, right: 12.0,),
    );
  }
}