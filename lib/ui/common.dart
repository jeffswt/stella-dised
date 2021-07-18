import 'package:flutter/material.dart';
import 'package:stella/ui/neumorph.dart';

routePush(BuildContext context, Widget Function(BuildContext) builder,
    [dynamic payload]) async {
  var res = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: builder,
      settings: RouteSettings(
        arguments: payload,
      ),
    ),
  );
  return res;
}

class SectionTitle extends StatelessWidget {
  /// Section title
  final String title;

  /// Upon "more" button tap. Won't display that button if this is [null].
  final Function()? onTap;

  SectionTitle({
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> row = [
      Expanded(
        child: Container(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: StellaTheme.of(context).hintColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
          padding: EdgeInsets.only(
            left: StellaTheme.of(context).padding.left,
            top: StellaTheme.of(context).blockPadding,
            bottom: StellaTheme.of(context).blockPadding * 0.4,
          ),
        ),
        flex: 10,
      ),
      Expanded(
        child: Container(),
        flex: 1,
      ),
    ];
    if (onTap != null)
      row.add(Container(
        child: neuIconButton(context, Icons.more_horiz),
        padding: EdgeInsets.only(top: 38.0, right: 20.0),
      ));
    return Row(
      children: row,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}

Widget defaultTile(
  BuildContext context, {
  required double width,
  required double height,
  required String title,
  required String imagePath,
  required Function() onPressed,
}) {
  Widget image = ClipRRect(
    child: Image.asset(
      imagePath,
      fit: BoxFit.cover,
      width: width,
      height: height,
    ),
    borderRadius: BorderRadius.circular(8.0),
  );
  Widget button = NeuButton(
    child: Column(
      children: [
        image,
        Container(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          padding: EdgeInsets.only(
            top: 8.0,
            left: 12.0,
            right: 12.0,
          ),
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
    ),
    elevation: 12.0,
    shape: NeuShape.Concave,
    onPressed: onPressed,
  );
  return Container(
    child: button,
    width: width,
    height: height + 50.0,
    margin: EdgeInsets.symmetric(
      horizontal: StellaTheme.of(context).tilePadding / 2,
    ),
  );
}
