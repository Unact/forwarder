import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final Widget title;
  final Widget trailing;
  final int titleFlex;
  final int trailingFlex;

  InfoRow({
    Key key,
    this.title,
    this.trailing,
    this.titleFlex = 1,
    this.trailingFlex = 1
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Flexible(
            flex: titleFlex,
            child: Container(
              height: 48,
              child: Align(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(child: title)
              )
            ),
          ),
          Flexible(
            flex: trailingFlex,
            child: Container(
              height: 48,
              child: Align(
                alignment: Alignment.centerRight,
                child: SingleChildScrollView(child: trailing)
              )
            )
          )
        ]
      ),
    );
  }
}
