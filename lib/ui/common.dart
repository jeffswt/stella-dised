import 'package:flutter/material.dart';
import 'package:stella/ui/neumorph.dart';

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
        flex: 1,
      ),
    ];
    return Row(
      children: row,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
